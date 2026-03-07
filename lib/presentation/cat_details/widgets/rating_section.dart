import 'package:flutter/material.dart';
import '../../../domain/entities/breed.dart';
import 'section_card.dart';
import 'rating_indicator.dart';

class RatingSection extends StatelessWidget {
  final Breed breed;

  const RatingSection({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: Theme.of(context).colorScheme.secondary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Characteristics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Ratings from 1 to 5',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 20),
          RatingIndicator(title: 'Affection', value: breed.affectionLevel),
          RatingIndicator(title: 'Intelligence', value: breed.intelligence),
          RatingIndicator(title: 'Energy', value: breed.energyLevel),
          RatingIndicator(title: 'Child Friendly', value: breed.childFriendly),
          RatingIndicator(title: 'Dog Friendly', value: breed.dogFriendly),
          RatingIndicator(title: 'Health', value: breed.healthIssues),
          RatingIndicator(title: 'Shedding', value: breed.sheddingLevel),
          RatingIndicator(title: 'Grooming', value: breed.grooming),
          RatingIndicator(title: 'Vocalisation', value: breed.vocalisation),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}