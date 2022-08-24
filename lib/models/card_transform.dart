class CardTransform {
  CardTransform({
    this.x = 0,
    this.y = 0,
    this.angle = 0,
    this.scale = 1,
  });
  double x;
  double y;
  double angle;
  double scale;

  CardTransform transform(CardTransform other, double transitionPos) {
    return CardTransform(
      x: _transformValue(x, other.x, transitionPos),
      y: _transformValue(y, other.y, transitionPos),
      angle: _transformValue(angle, other.angle, transitionPos),
      scale: _transformValue(scale, other.scale, transitionPos),
    );
  }

  double _transformValue(double valueA, double valueB, double transformPos) =>
      valueA - ((valueA - valueB) * transformPos);
}
