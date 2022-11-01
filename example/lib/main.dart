// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:carousel/carousel.dart';

import 'package:carousel_example/pokemon.dart';
import 'package:carousel_example/pokemon_card.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math;

void main() {
  runApp(const CarouselExampleApp());
}

class CarouselExampleApp extends StatefulWidget {
  const CarouselExampleApp({Key? key}) : super(key: key);

  @override
  State<CarouselExampleApp> createState() => _CarouselExampleAppState();
}

class _CarouselExampleAppState extends State<CarouselExampleApp> {
  Pokemon? selected;

  final List<Pokemon> pokemons = [
    Pokemon(name: 'Bulbasaur', nr: 1, types: ['grass', 'poison']),
    Pokemon(name: 'Charmander', nr: 4, types: ['fire']),
    Pokemon(name: 'Squirtle', nr: 7, types: ['water']),
    Pokemon(name: 'Caterpie', nr: 10, types: ['bug']),
    Pokemon(name: 'Pidgey', nr: 16, types: ['normal', 'flying']),
    Pokemon(name: 'Pikachu', nr: 25, types: ['electric']),
    Pokemon(name: 'Machop', nr: 66, types: ['fighting']),
    Pokemon(name: 'Geodude', nr: 74, types: ['rock', 'ground']),
  ];

  Widget _buildCard(BuildContext context, int index) {
    return PokemonCard(
      pokemon: pokemons[index % pokemons.length],
    );
  }

  void _onClick(int index) {
    setState(() {
      selected = pokemons[index % pokemons.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  const SizedBox(height: 50),
                  Carousel(
                    pageViewHeight: 220,
                    selectableCardId: 4,
                    onCardClick: _onClick,
                    transforms: [
                      CardTransform(
                        x: 220,
                        y: -85,
                        angle: -math.pi / 12,
                        scale: 0.3,
                        opacity: 0.2,
                      ),
                      CardTransform(
                        x: 230,
                        y: -80,
                        angle: math.pi / 12,
                        scale: 0.5,
                        opacity: 0.4,
                      ),
                      CardTransform(
                        x: 200,
                        y: -75,
                        angle: -math.pi / 12,
                        scale: 0.6,
                        opacity: 0.6,
                      ),
                      CardTransform(
                        x: 110,
                        y: -60,
                        angle: math.pi / 12,
                        scale: 0.7,
                        opacity: 0.8,
                      ),
                      CardTransform(
                        x: 0,
                        y: 0,
                        angle: 0,
                        scale: 1,
                        opacity: 1.0,
                      ),
                      CardTransform(
                        x: -270,
                        y: 70,
                        angle: -math.pi / 50,
                        scale: 1,
                        opacity: 0.5,
                      ),
                    ],
                    builder: _buildCard,
                  ),
                  Carousel(
                    selectableCardId: 1,
                    onCardClick: _onClick,
                    alignment: Alignment.center,
                    transforms: [
                      CardTransform(x: 0, y: 0, angle: 0, scale: 0.5),
                      CardTransform(x: 0, y: 0, angle: 0, scale: 1),
                      CardTransform(
                          x: 300, y: 0, angle: math.pi / 20, scale: 1),
                    ],
                    builder: _buildCard,
                  ),
                ],
              ),
            ),
            if (selected != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text('Clicked: ${selected!.name}'),
              ),
          ],
        ),
      ),
    );
  }
}
