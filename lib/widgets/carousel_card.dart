import 'package:carousel/models/card_transform.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    required this.cardTransform,
    required this.child,
    Key? key,
  }) : super(key: key);

  final CardTransform cardTransform;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(cardTransform.x, cardTransform.y),
      child: Transform.rotate(
        angle: cardTransform.angle,
        child: Transform.scale(
          scale: cardTransform.scale,
          child: child,
        ),
      ),
    );
  }
}
