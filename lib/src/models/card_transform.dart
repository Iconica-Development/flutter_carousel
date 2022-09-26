class CardTransform {
  /// Used by [Carousel] to build cards on the correct position.
  CardTransform({
    this.x = 0,
    this.y = 0,
    this.angle = 0,
    this.scale = 1,
    this.opacity = 1.0,
  })  : assert(
          opacity >= 0,
          'Opacity cannot be negative',
        ),
        assert(
          opacity <= 1.0,
          'Opacity needs to be between 0.0 and 1.0',
        );

  double x;
  double y;
  double angle;
  double scale;
  double opacity;

  /// [transitionPos] is a position value of a swipe for example.
  /// [other] is the position, scale, rotation
  /// which the current [CardTransform] need to be transformed to.
  CardTransform transform(CardTransform other, double transitionPos) {
    return CardTransform(
      x: _transformValue(x, other.x, transitionPos),
      y: _transformValue(y, other.y, transitionPos),
      angle: _transformValue(angle, other.angle, transitionPos),
      scale: _transformValue(scale, other.scale, transitionPos),
      opacity: _transformValue(opacity, other.opacity, transitionPos),
    );
  }

  double _transformValue(double valueA, double valueB, double transformPos) =>
      valueA - ((valueA - valueB) * transformPos);
}
