import 'package:flutter/material.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

class FavoriteCharactersScreen extends StatelessWidget {
  FavoriteCharactersScreen({super.key});

  final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Избранное")),
      body: ListView.separated(
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          return CharacterCard();
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 12);
        },
        itemCount: list.length,
      ),
    );
  }
}
