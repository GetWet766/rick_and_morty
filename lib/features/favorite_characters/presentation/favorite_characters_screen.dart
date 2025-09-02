import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/controllers/controllers.dart'
    show ThemeController, FavoritesController, CharacterListController;
import 'package:rick_and_morty/services/services.dart'
    show ApiService, CacheService;
import 'package:rick_and_morty/widgets/widgets.dart' show CharacterCard;

import 'package:rick_and_morty/models/models.dart' show Character;

import 'package:rick_and_morty/repository/repository.dart'
    show CharacterRepository;

enum FavSort { name, species, gender, locationName, status }

class FavoriteCharactersScreen extends StatefulWidget {
  final ThemeController themeController;
  final FavoritesController favoritesController;

  const FavoriteCharactersScreen({
    super.key,
    required this.themeController,
    required this.favoritesController,
  });

  @override
  State<FavoriteCharactersScreen> createState() =>
      _FavoriteCharactersScreenState();
}

class _FavoriteCharactersScreenState extends State<FavoriteCharactersScreen> {
  late final CharacterListController characterListController;
  FavSort sort = FavSort.name;

  @override
  void initState() {
    super.initState();
    characterListController = CharacterListController(
      repo: CharacterRepository(api: ApiService(), cache: CacheService()),
    );
    characterListController.refresh();
  }

  VoidCallback _clearCache(context) => () async {
    await Hive.box('characters').clear();
    await characterListController.refresh();
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Кеш очищен')));
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Избранное"),
        actions: [
          IconButton(
            tooltip: widget.themeController.isDark
                ? 'Светлая тема'
                : 'Тёмная тема',
            onPressed: widget.themeController.toggle,
            icon: Icon(
              widget.themeController.isDark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Row(
              children: [
                const Text('Сортировка:'),
                const SizedBox(width: 12),
                DropdownButton<FavSort>(
                  value: sort,
                  onChanged: (v) => setState(() => sort = v ?? FavSort.name),
                  items: const [
                    DropdownMenuItem(
                      value: FavSort.name,
                      child: Text('по имени'),
                    ),
                    DropdownMenuItem(
                      value: FavSort.species,
                      child: Text('по виду'),
                    ),
                    DropdownMenuItem(
                      value: FavSort.gender,
                      child: Text('по гендеру'),
                    ),
                    DropdownMenuItem(
                      value: FavSort.status,
                      child: Text('по статусу'),
                    ),
                    DropdownMenuItem(
                      value: FavSort.locationName,
                      child: Text('по месту'),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Очистить кеш персонажей',
                  icon: const Icon(Icons.delete_sweep),
                  onPressed: _clearCache(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: widget.favoritesController,
              builder: (context, _) {
                final cache = CacheService();
                final ids = widget.favoritesController.ids.toList();
                final list = <Character>[];
                for (final id in ids) {
                  final character = cache.getCharacter(id);
                  if (character != null) list.add(character);
                }

                list.sort((a, b) {
                  switch (sort) {
                    case FavSort.name:
                      return a.name.compareTo(b.name);
                    case FavSort.species:
                      return a.species.compareTo(b.species);
                    case FavSort.gender:
                      return a.gender.compareTo(b.gender);
                    case FavSort.status:
                      return a.status.compareTo(b.status);
                    case FavSort.locationName:
                      return a.locationName.compareTo(b.locationName);
                  }
                });

                if (list.isEmpty) {
                  return const Center(child: Text('Нет избранных персонажей'));
                }

                return ListView.separated(
                  padding: EdgeInsets.all(12),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final character = list[index];

                    return Dismissible(
                      key: ValueKey('fav_${character.id}'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) =>
                          widget.favoritesController.remove(character.id),
                      child: CharacterCard(
                        character: character,
                        isFavorite: true,
                        onToggleFavorite: () =>
                            widget.favoritesController.remove(character.id),
                      ),
                    );
                  },
                  separatorBuilder: (_, _) {
                    return SizedBox(height: 12);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
