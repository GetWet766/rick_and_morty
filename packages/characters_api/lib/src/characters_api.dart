import 'package:characters_api/characters_api.dart';

abstract class CharactersApi {
  const CharactersApi();

  Stream<List<Character>> getCharacters();

  Future<void> saveCharacter(Character character);

  Future<void> deleteCharacter(String id);

  Future<int> clearCompleted();

  Future<int> completeAll({required bool isCompleted});

  Future<void> close();
}

class CharacterNotFoundException implements Exception {}
