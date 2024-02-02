// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:carousel/src/models/card_transform.dart';
import 'package:flutter/material.dart';

/// Transformed card used in [Carousel]
class CarouselCard extends StatelessWidget {
  const CarouselCard({
    required this.cardTransform,
    required this.child,
    super.key,
  });

  final CardTransform cardTransform;
  final Widget child;

  @override
  Widget build(BuildContext context) => Transform.translate(
        offset: Offset(cardTransform.x, cardTransform.y),
        child: Transform.rotate(
          angle: cardTransform.angle,
          child: Transform.scale(
            scale: cardTransform.scale,
            child: Opacity(
              opacity: cardTransform.opacity,
              child: child,
            ),
          ),
        ),
      );
}
