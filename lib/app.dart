import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/all_characters/all_characters.dart';
import 'package:rick_and_morty/features/favorite_characters/favorite_characters.dart';
import 'package:rick_and_morty/widgets/widgets.dart' show BottomNavigation;

import 'controllers/controllers.dart' show ThemeController, FavoritesController;

class RickAndMortyApp extends StatefulWidget {
  const RickAndMortyApp({super.key});

  @override
  State<RickAndMortyApp> createState() => _RickAndMortyAppState();
}

class _RickAndMortyAppState extends State<RickAndMortyApp> {
  final theme = ThemeController();
  final favorites = FavoritesController();

  @override
  void initState() {
    super.initState();
    theme.load();
    favorites.load();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([theme, favorites]),
      builder: (context, _) => MaterialApp(
        title: 'Rick & Morty',
        debugShowCheckedModeBanner: false,
        themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyan,
            brightness: Brightness.dark,
          ),
        ),
        home: BottomNavigation(
          screens: [
            AllCharactersScreen(
              themeController: theme,
              favoritesController: favorites,
            ),
            FavoriteCharactersScreen(
              themeController: theme,
              favoritesController: favorites,
            ),
          ],
        ),
      ),
    );
  }
}
