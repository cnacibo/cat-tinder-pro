import '../../domain/entities/breed.dart';

class BreedModel extends Breed {

  BreedModel({
    required super.weight,
    required super.id,
    required super.name,
    super.temperament,
    super.origin,
    super.countryCodes,
    super.countryCode,
    super.lifeSpan,
    super.wikipediaUrl,
    super.description,
    super.adaptability,
    super.affectionLevel,
    super.childFriendly,
    super.dogFriendly,
    super.energyLevel,
    super.grooming,
    super.healthIssues,
    super.intelligence,
    super.sheddingLevel,
    super.socialNeeds,
    super.strangerFriendly,
    super.vocalisation,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      weight: Map<String, String>.from(json['weight'] ?? {}),
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Breed',
      temperament: json['temperament'],
      origin: json['origin'],
      countryCodes: json['country_codes'],
      countryCode: json['country_code'],
      lifeSpan: json['life_span'],
      wikipediaUrl: json['wikipedia_url'],
      description: json['description'],
      adaptability: json['adaptability'],
      affectionLevel: json['affection_level'],
      childFriendly: json['child_friendly'],
      dogFriendly: json['dog_friendly'],
      energyLevel: json['energy_level'],
      grooming: json['grooming'],
      healthIssues: json['health_issues'],
      intelligence: json['intelligence'],
      sheddingLevel: json['shedding_level'],
      socialNeeds: json['social_needs'],
      strangerFriendly: json['stranger_friendly'],
      vocalisation: json['vocalisation'],
    );
  }
}
