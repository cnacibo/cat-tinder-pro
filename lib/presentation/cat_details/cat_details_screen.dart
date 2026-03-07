import 'package:flutter/material.dart';
import '../../domain/entities/breed.dart';
import 'widgets/cat_profile_image.dart';
import 'widgets/temperament_section.dart';
import 'widgets/rating_section.dart';
import 'widgets/section_card.dart';
import 'widgets/breed_info_section.dart';

class CatDetailsScreen extends StatelessWidget {
  final Breed breed;
  final String catImageUrl;
  const CatDetailsScreen({
    super.key,
    required this.breed,
    required this.catImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          breed.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatProfileImage(imageUrl: catImageUrl),
              const SizedBox(height: 32),
              SectionCard(child: BreedInfoSection(breed: breed)),
              const SizedBox(height: 24),
              if (breed.temperament != null && breed.temperament!.isNotEmpty)
                TemperamentSection(temperament: breed.temperament!),
              const SizedBox(height: 24),
              RatingSection(breed: breed),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}