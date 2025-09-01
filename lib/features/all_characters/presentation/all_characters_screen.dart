import 'package:flutter/material.dart';
import 'package:rick_and_morty/widgets/character_card.dart';

class AllCharactersScreen extends StatelessWidget {
  const AllCharactersScreen({super.key});

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
        itemCount: 20,
      ),
    );
  }
}
