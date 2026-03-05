import '../../domain/entities/cat_image.dart';
import 'breed_model.dart';

class CatImageModel extends CatImage {

  CatImageModel({
    required super.id,
    required super.url,
    required super.width,
    required super.height,
    required super.breeds,
    super.favourite,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) {
    return CatImageModel(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      breeds: (json['breeds'] as List<dynamic>? ?? [])
          .map((breedJson) => BreedModel.fromJson(breedJson))
          .toList(),
      favourite: json['favourite'],
    );
  }
}
