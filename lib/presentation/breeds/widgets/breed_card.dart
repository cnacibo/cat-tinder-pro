import 'package:flutter/material.dart';
import '../../../domain/entities/breed.dart';
import 'rating_chip.dart';

class BreedCard extends StatelessWidget {
  final Breed breed;
  final VoidCallback onTap;

  const BreedCard({
    super.key,
    required this.breed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surface;
    final textColor = Theme.of(context).colorScheme.onSurface;
    final countryColor = Theme.of(context).colorScheme.secondary;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: cardColor, 
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      breed.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (breed.origin != null)
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: textColor.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            breed.origin!,
                            style: TextStyle(
                              fontSize: 14,
                              color: countryColor,
                            ),
                          ),
                        ],
                      ),
                    if (breed.temperament != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        breed.temperament!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        RatingChip(emoji: '❤️', rating: breed.affectionLevel ?? 0),
                        const SizedBox(width: 8),
                        RatingChip(emoji: '⚡', rating: breed.energyLevel ?? 0),
                        const SizedBox(width: 8),
                        RatingChip(emoji: '🧠', rating: breed.intelligence ?? 0),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}