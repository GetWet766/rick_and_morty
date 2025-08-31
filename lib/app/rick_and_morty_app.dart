import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/all_characters/presentation/all_characters_screen.dart';
import 'package:rick_and_morty/features/favorite_characters/favorite_characters.dart';
import 'package:rick_and_morty/widgets/bottom_navigation.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
      ),
      home: BottomNavigation(
        screens: [AllCharactersScreen(), FavoriteCharactersScreen()],
      ),
    );
  }
}
