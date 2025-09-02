import 'package:flutter/material.dart';
import 'package:rick_and_morty/controllers/controllers.dart'
    show ThemeController, FavoritesController, CharacterListController;
import 'package:rick_and_morty/services/services.dart'
    show ApiService, CacheService;
import 'package:rick_and_morty/repository/repository.dart'
    show CharacterRepository;
import 'package:rick_and_morty/widgets/widgets.dart'
    show CharacterCard, ErrorRetry;

class AllCharactersScreen extends StatefulWidget {
  final ThemeController themeController;
  final FavoritesController favoritesController;

  const AllCharactersScreen({
    super.key,
    required this.themeController,
    required this.favoritesController,
  });

  @override
  State<AllCharactersScreen> createState() => _AllCharactersScreenState();
}

class _AllCharactersScreenState extends State<AllCharactersScreen> {
  late final CharacterListController characterListController;
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    characterListController = CharacterListController(
      repo: CharacterRepository(api: ApiService(), cache: CacheService()),
    );
    characterListController.refresh();

    _scroll.addListener(() {
      if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 300) {
        characterListController.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    characterListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Список персонажей"),
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
      body: RefreshIndicator(
        onRefresh: characterListController.refresh,
        child: AnimatedBuilder(
          animation: Listenable.merge([
            characterListController,
            widget.favoritesController,
          ]),
          builder: (context, _) {
            if (characterListController.error != null &&
                characterListController.items.isEmpty) {
              return ErrorRetry(
                message: characterListController.error!,
                onRetry: characterListController.refresh,
              );
            }

            if (characterListController.items.isEmpty &&
                characterListController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              controller: _scroll,
              itemCount:
                  characterListController.items.length +
                  (characterListController.hasMore ||
                          characterListController.isLoading
                      ? 1
                      : 0),
              padding: EdgeInsets.all(12),
              itemBuilder: (context, index) {
                if (index >= characterListController.items.length) {
                  // футер
                  if (characterListController.error != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ErrorRetry(
                        message: characterListController.error!,
                        onRetry: characterListController.loadMore,
                      ),
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final character = characterListController.items[index];
                final isFavorite = widget.favoritesController.isFav(
                  character.id,
                );

                return CharacterCard(
                  character: character,
                  isFavorite: isFavorite,
                  onToggleFavorite: () =>
                      widget.favoritesController.toggle(character.id),
                );
              },
              separatorBuilder: (_, _) {
                return SizedBox(height: 12);
              },
            );
          },
        ),
      ),
    );
  }
}
