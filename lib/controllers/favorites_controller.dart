import 'package:flutter/foundation.dart';
import '../services/services.dart';

class FavoritesController extends ChangeNotifier {
  final _cache = CacheService();
  Set<int> _ids = {};

  Set<int> get ids => _ids;
  bool isFav(int id) => _ids.contains(id);

  void load() {
    _ids = _cache.loadFavoriteIds();
    notifyListeners();
  }

  Future<void> toggle(int id) async {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
    }
    await _cache.saveFavoriteIds(_ids);
    notifyListeners();
  }

  Future<void> remove(int id) async {
    _ids.remove(id);
    await _cache.saveFavoriteIds(_ids);
    notifyListeners();
  }
}
