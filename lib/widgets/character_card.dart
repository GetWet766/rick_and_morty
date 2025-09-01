import 'package:flutter/material.dart';

class CharacterCard extends StatefulWidget {
  const CharacterCard({super.key});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            Row(
              children: [
                /// Image
                Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Row(
                      children: [
                        Text(
                          "Toxic Rick",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),

                        /// Species
                        Text(
                          "Humanoid",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),

                    /// Gender
                    Row(
                      children: [
                        Icon(
                          Icons.male_rounded,
                          size: 14,
                          color: Colors.blue.shade700,
                        ),
                        SizedBox(width: 4),
                        Text("Male"),
                      ],
                    ),

                    /// Location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: Colors.red.shade700,
                        ),
                        SizedBox(width: 4),
                        Text("Earth"),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    isFavorite
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: 28,
                    color: isFavorite ? Colors.yellow.shade700 : Colors.black38,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
