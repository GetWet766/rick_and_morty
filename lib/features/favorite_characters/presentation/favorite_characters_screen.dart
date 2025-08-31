import 'package:flutter/material.dart';

class FavoriteCharactersScreen extends StatelessWidget {
  FavoriteCharactersScreen({super.key});

  final list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Избранное")),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      /// Image
                      // Image.network("src")
                      /// Name
                      Text("Rick"),

                      ///
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 12);
        },
        itemCount: list.length,
      ),
    );
  }
}
