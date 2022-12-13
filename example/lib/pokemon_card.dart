// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:carousel_example/extensions/string.dart';
import 'package:carousel_example/pokemon.dart';
import 'package:carousel_example/pokemon_types.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({required this.pokemon, Key? key}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(pokemon.name, style: textStyle),
                const Spacer(),
                Text(pokemon.nr.toString().padLeft(3, '0'), style: textStyle),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: Text('Type', style: textStyle),
            ),
            Row(
              children: [
                for (var type in pokemon.types) ...[
                  TypeBadge(type: type),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TypeBadge extends StatelessWidget {
  const TypeBadge({
    super.key,
    required this.type,
  });

  final PokemonType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: getTypeColor(type),
      ),
      child: Center(
        child: Text(
          type.name.capitalize(),
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Color getTypeColor(PokemonType type) {
    switch (type) {
      case PokemonType.fire:
        return const Color(0xFFF08030);
      case PokemonType.water:
        return const Color(0xFF6890F0);
      case PokemonType.grass:
        return const Color(0xFF78C850);
      case PokemonType.normal:
        return const Color(0xFFA8A878);
      case PokemonType.electric:
        return const Color(0xFFF8D030);
      case PokemonType.ice:
        return const Color(0xFF98D8D8);
      case PokemonType.fighting:
        return const Color(0xFFC03028);
      case PokemonType.poison:
        return const Color(0xFFA040A0);
      case PokemonType.ground:
        return const Color(0xFFE0C068);
      case PokemonType.flying:
        return const Color(0xFFA890F0);
      case PokemonType.psychic:
        return const Color(0xFFF85888);
      case PokemonType.bug:
        return const Color(0xFFA8B820);
      case PokemonType.rock:
        return const Color(0xFFB8A038);
      case PokemonType.ghost:
        return const Color(0xFF705898);
      case PokemonType.dark:
        return const Color(0xFF705848);
      case PokemonType.dragon:
        return const Color(0xFF7038F8);
      case PokemonType.steel:
        return const Color(0xFFB8B8D0);
      case PokemonType.fairy:
        return const Color(0xFFEE99AC);
      default:
        return const Color(0xFF68A090);
    }
  }
}
