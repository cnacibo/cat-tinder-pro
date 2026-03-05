class Breed {
  final Map<String, String> weight;
  final String id;
  final String name;
  final String? temperament;
  final String? origin;
  final String? countryCodes;
  final String? countryCode;
  final String? lifeSpan;
  final String? wikipediaUrl;
  final String? description;
  final int? adaptability;
  final int? affectionLevel;
  final int? childFriendly;
  final int? dogFriendly;
  final int? energyLevel;
  final int? grooming;
  final int? healthIssues;
  final int? intelligence;
  final int? sheddingLevel;
  final int? socialNeeds;
  final int? strangerFriendly;
  final int? vocalisation;

  Breed({
    required this.weight,
    required this.id,
    required this.name,
    this.temperament,
    this.origin,
    this.countryCodes,
    this.countryCode,
    this.lifeSpan,
    this.wikipediaUrl,
    this.description,
    this.adaptability,
    this.affectionLevel,
    this.childFriendly,
    this.dogFriendly,
    this.energyLevel,
    this.grooming,
    this.healthIssues,
    this.intelligence,
    this.sheddingLevel,
    this.socialNeeds,
    this.strangerFriendly,
    this.vocalisation,
  });
}
