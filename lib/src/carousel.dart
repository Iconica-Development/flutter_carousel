// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:carousel/src/models/card_transform.dart';
import 'package:carousel/src/widgets/carousel_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef CarouselCardBuilder = Widget Function(BuildContext context, int index);

class Carousel extends StatefulWidget {
  /// Animated cards by swiping.
  /// Each card can change its rotation, position
  /// and scale when swiping the cards.
  /// Transform path can be privided using [transforms]
  const Carousel({
    required this.transforms,
    required this.builder,
    required this.selectableCardId,
    this.pageViewHeight = 300,
    this.onPageChanged,
    this.alignment = AlignmentDirectional.topStart,
    this.onCardClick,
    this.initialPage = 0,
    this.allowInfiniteScrollingBackwards = false,
    super.key,
  });

  /// A list of transforms to calculate the position of the card when swiping.
  /// Every item in the list is one of the possible card positions.
  final List<CardTransform> transforms;

  /// The index of the transform card which acts as the selected card.
  final int selectableCardId;

  /// Builder for the card given a [context] and a [index] to
  /// identify the right card.
  final CarouselCardBuilder builder;

  /// Called when selected card is changed to the next one.
  final void Function(int value)? onPageChanged;

  // Callen when selected card is clicked.
  final void Function(int value)? onCardClick;

  /// Alignment of the cards.
  final AlignmentGeometry alignment;

  /// Size of the pageview used to capture swipe gestures.
  final double pageViewHeight;

  /// The page to show when first creating the [Carousel].
  final int initialPage;

  /// Whether to allow infinite scrolling backwards. Defaults to false. If true,
  /// this works by using a very large number of pages (10000).
  /// Works in conjunction with [initialPage].
  final bool allowInfiniteScrollingBackwards;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  double _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.allowInfiniteScrollingBackwards
          ? 10000 + widget.initialPage
          : widget.initialPage,
    );
    _currentPage = _pageController.initialPage.toDouble();

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
  Widget build(BuildContext context) => Stack(
        alignment: widget.alignment,
        children: [
          AnimatedBuilder(
            animation: _pageController,
            builder: (context, _) {
              var transitionPos = _currentPage % 1;
              var index = _currentPage.floor();
              var length = widget.transforms.length - 1;

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
              scrollBehavior: _MouseSwipeOnWeb(),
              onPageChanged: widget.onPageChanged,
              controller: _pageController,
              itemBuilder: (context, index) => Visibility(
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
              ),
            ),
          ),
        ],
      );
}

class _MouseSwipeOnWeb extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
