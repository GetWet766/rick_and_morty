import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:characters_api/characters_api.dart';
import 'package:uuid/uuid.dart';

part 'character.g.dart';

@immutable
@JsonSerializable()
class Character extends Equatable {
  Character({
    required this.title,
    String? id,
    this.description = '',
    this.isCompleted = false,
  }) : assert(
         id == null || id.isNotEmpty,
         'id must either be null or not empty',
       ),
       id = id ?? const Uuid().v4();

  final String id;

  final String title;
  final String description;

  final bool isCompleted;

  Character copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Character(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static Character fromJson(JsonMap json) => _$CharacterFromJson(json);

  JsonMap toJson() => _$CharacterToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
