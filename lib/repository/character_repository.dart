import '../models/models.dart';
import '../services/services.dart';

class CharacterRepository {
  final ApiService api;
  final CacheService cache;

  CharacterRepository({required this.api, required this.cache});

  /// Пытаемся загрузить с сети, при ошибке — из кеша.
  Future<(List<Character>, int?)> getPage(int page) async {
    try {
      final (list, next) = await api.fetchCharacters(page: page);
      // Закешируем
      await cache.putCharacters(list);
      return (list, next);
    } catch (e) {
      // Оффлайн режим — отдаем все из кеша (а пагинацию останавливаем)
      final all = cache.getAllCharacters();
      return (all, null);
    }
  }
}
