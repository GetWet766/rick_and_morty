import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<(List<Character>, int?)> fetchCharacters({int page = 1}) async {
    final url = Uri.parse('$baseUrl/character?page=$page');
    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${res.reasonPhrase}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final info = data['info'] as Map<String, dynamic>;
    final nextUrl = info['next'] as String?;
    final nextPage = nextUrl == null
        ? null
        : int.tryParse(Uri.parse(nextUrl).queryParameters['page'] ?? '');

    final results = (data['results'] as List)
        .map((e) => Character.fromJson(e as Map<String, dynamic>))
        .toList();

    return (results, nextPage);
  }
}
