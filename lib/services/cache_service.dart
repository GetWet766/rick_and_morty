import 'package:hive_flutter/hive_flutter.dart';
import '../models/models.dart';

class CacheService {
  final _characters = Hive.box('characters');
  final _favorites = Hive.box('favorites');

  // Characters cache by id
  Future<void> putCharacters(List<Character> list) async {
    final batch = <dynamic, dynamic>{};
    for (final c in list) {
      batch[c.id] = c.toJson();
    }
    await _characters.putAll(batch);
  }

  List<Character> getAllCharacters() {
    return _characters.values
        .map((e) => Character.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Character? getCharacter(int id) {
    final raw = _characters.get(id);
    if (raw == null) return null;
    return Character.fromJson(Map<String, dynamic>.from(raw));
  }

  // Favorites
  Set<int> loadFavoriteIds() {
    final list = List<int>.from(_favorites.get('ids', defaultValue: <int>[]));
    return list.toSet();
  }

  Future<void> saveFavoriteIds(Set<int> ids) async {
    await _favorites.put('ids', ids.toList());
  }
}
