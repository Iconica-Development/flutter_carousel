// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

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
