import 'package:flutter/material.dart';
import '../../../domain/entities/breed.dart';
import 'detail_row.dart';
import 'characteristic.dart';

class BreedDetails extends StatelessWidget {
  final Breed breed;

  const BreedDetails({
    super.key,
    required this.breed
  });

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        breed.name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              breed.description ?? 'No description available 😿',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            DetailRow(label: '📍 Origin', value: breed.origin ?? 'Unknown'),
            DetailRow(label: '😸 Temperament', value: breed.temperament ?? 'Unknown'),
            DetailRow(label: '📅 Life Span', value: '${breed.lifeSpan} years'),
            const SizedBox(height: 16),
            Text(
              'Characteristics',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Characteristic(label: 'Affection', value: breed.affectionLevel),
                Characteristic(label: 'Energy', value: breed.energyLevel),
                Characteristic(label: 'Intelligence', value: breed.intelligence),
                Characteristic(label: 'Child Friendly', value: breed.childFriendly),
                Characteristic(label: 'Health', value: breed.healthIssues),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }
}