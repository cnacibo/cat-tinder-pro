import 'package:flutter/material.dart';
import '../../../domain/entities/breed.dart';
import 'info_card.dart';

class BreedInfoSection extends StatelessWidget {
  final Breed breed;

  const BreedInfoSection({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          breed.description ?? 'No description available 😿',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: InfoCard(
                title: 'Country',
                icon: Icons.location_on,
                value: breed.origin ?? 'Unknown',
                bgColor: Colors.blue.shade50,
                iconColor: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InfoCard(
                title: 'Life Span',
                icon: Icons.calendar_today,
                value: '${breed.lifeSpan} years',
                bgColor: Colors.green.shade50,
                iconColor: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: InfoCard(
                title: 'Weight (kg)',
                icon: Icons.scale,
                value: breed.weight['metric'] ?? '—',
                bgColor: Colors.orange.shade50,
                iconColor: Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InfoCard(
                title: 'Weight (lb)',
                icon: Icons.scale,
                value: breed.weight['imperial'] ?? '—',
                bgColor: Colors.purple.shade50,
                iconColor: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}