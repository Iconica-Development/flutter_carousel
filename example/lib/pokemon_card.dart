import 'package:carousel_example/pokemon.dart';
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
        color: Colors.blue.shade700,
        boxShadow: const [
          BoxShadow(blurRadius: 4),
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
              child: Text('Types', style: textStyle),
            ),
            Row(
              children: [
                for (var type in pokemon.types) ...[
                  Container(
                    height: 25,
                    width: 60,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(type.hashCode).withAlpha(255),
                    ),
                    child: Center(
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
