import 'dart:math';

import 'package:carousel/models/card_transform.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('card transform', () {
    test('card transform', () {
      var expected =
          CardTransform(x: 174, y: 0, angle: 0.091106186954104, scale: 0.79);

      var actual = CardTransform(x: 300, y: 0, angle: pi / 20, scale: 1)
          .transform(CardTransform(x: 0, y: 0, angle: 0, scale: 0.5), 0.42);

      expect(actual.x, equals(expected.x));
      expect(actual.y, equals(expected.y));
      expect(actual.angle, equals(expected.angle));
      expect(actual.scale, equals(expected.scale));
    });
  });
}
