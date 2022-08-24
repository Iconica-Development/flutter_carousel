class Pokemon {
  Pokemon({
    required this.name,
    required this.nr,
    this.types = const [],
  });
  String name;
  int nr;
  List<String> types = const [];
}
