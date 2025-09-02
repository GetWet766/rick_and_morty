import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/models.dart' show Character;

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  bool get isMale => character.gender == 'Male';

  Widget _genderIcon(ThemeData theme) {
    final gender = character.gender.toLowerCase();
    if (gender == 'male') {
      return Icon(Icons.male_rounded, color: Colors.blue.shade700, size: 14);
    }
    if (gender == 'female') {
      return Icon(Icons.female_rounded, color: Colors.pink.shade700, size: 14);
    }
    return Icon(Icons.male_rounded, color: theme.colorScheme.outline, size: 14);
  }

  Widget _statusIcon(ThemeData theme) {
    final status = character.status.toLowerCase();
    if (status == 'alive') {
      return Icon(
        Icons.sentiment_satisfied_alt_rounded,
        size: 14,
        color: Colors.green.shade700,
      );
    }
    if (status == 'dead') {
      return Icon(
        Icons.sentiment_dissatisfied_rounded,
        size: 14,
        color: Colors.red.shade700,
      );
    }
    return Icon(
      Icons.sentiment_neutral_rounded,
      size: 14,
      color: theme.colorScheme.outline,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Image
                Container(
                  height: 80,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CachedNetworkImage(
                      imageUrl: character.image,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, _, _) => const ColoredBox(
                        color: Colors.black12,
                        child: Center(child: Icon(Icons.broken_image_rounded)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Text(
                      character.name,
                      style: theme.textTheme.titleMedium,
                      overflow: TextOverflow.fade,
                    ),

                    /// Species
                    Text(character.species, style: theme.textTheme.bodySmall),

                    /// Gender
                    Row(
                      children: [
                        _genderIcon(theme),
                        SizedBox(width: 4),
                        Text(character.gender),
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
                        Text(
                          character.locationName,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),

                    /// Status
                    Row(
                      children: [
                        _statusIcon(theme),
                        SizedBox(width: 4),
                        Text(character.status),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 200),
                  tween: Tween(begin: 1, end: isFavorite ? 1.2 : 1.0),
                  builder: (context, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 28,
                      color: isFavorite ? Colors.yellow.shade700 : null,
                    ),
                    onPressed: onToggleFavorite,
                    tooltip: isFavorite
                        ? 'Удалить из избранного'
                        : 'В избранное',
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
