library carousel;

export 'package:carousel/carousel.dart';

import 'package:carousel/models/card_transform.dart';
import 'package:carousel/widgets/carousel_card.dart';
import 'package:flutter/material.dart';

typedef CarouselCardBuilder = Widget Function(BuildContext context, int index);

class Carousel extends StatefulWidget {
  const Carousel({
    required this.transforms,
    required this.builder,
    required this.selectableCardId,
    this.pageViewHeight = 300,
    this.onPageChanged,
    this.alignment = AlignmentDirectional.topStart,
    this.onCardClick,
    Key? key,
  }) : super(key: key);

  /// A list of transforms to calculate the position of the card when swiping.
  /// Every item in the list is one of the possible card positions.
  final List<CardTransform> transforms;

  /// The index of the transform card which acts as the selected card.
  final int selectableCardId;

  /// Builder for the card given a [context] and a [index] to identify the right card.
  final CarouselCardBuilder builder;

  /// Called when selected card is changed to the next one.
  final void Function(int value)? onPageChanged;

  // Callen when selected card is clicked.
  final void Function(int value)? onCardClick;

  /// Alignment of the cards.
  final AlignmentGeometry alignment;

  /// Size of the pageview used to capture swipe gestures.
  final double pageViewHeight;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController(initialPage: 0);
  double _currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      _currentPage = _pageController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.alignment,
      children: [
        AnimatedBuilder(
          animation: _pageController,
          builder: (context, _) {
            final transitionPos = _currentPage % 1;
            final index = _currentPage.floor();
            final length = widget.transforms.length - 1;

            return Stack(
              children: [
                for (var i = 0; i < length; i++) ...[
                  CarouselCard(
                    cardTransform: widget.transforms[i]
                        .transform(widget.transforms[i + 1], transitionPos),
                    child: widget.builder.call(context, index - i),
                  ),
                ],
              ],
            );
          },
        ),
        SizedBox(
          height: widget.pageViewHeight,
          child: PageView.builder(
            onPageChanged: widget.onPageChanged,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Visibility(
                visible: false,
                maintainState: true,
                maintainAnimation: true,
                maintainInteractivity: true,
                maintainSemantics: true,
                maintainSize: true,
                child: Stack(
                  alignment: widget.alignment,
                  children: [
                    GestureDetector(
                      onTap: () {
                        widget.onCardClick
                            ?.call(index - widget.selectableCardId);
                      },
                      child: widget.builder
                          .call(context, index - widget.selectableCardId),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
