import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../repository/repository.dart';

class CharacterListController extends ChangeNotifier {
  final CharacterRepository repo;

  CharacterListController({required this.repo});

  final List<Character> _items = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _error;

  List<Character> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;

  Future<void> refresh() async {
    _items.clear();
    _page = 1;
    _hasMore = true;
    _error = null;
    notifyListeners();
    await loadMore();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final (list, nextPage) = await repo.getPage(_page);
      if (_page == 1 && list.isEmpty) {
        _hasMore = false;
      }
      _items.addAll(list);
      _page = nextPage ?? _page + 1;
      _hasMore = nextPage != null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
