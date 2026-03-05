import 'breed.dart';

class CatImage {
  final String id;
  final String url;
  final int width;
  final int height;
  final List<Breed> breeds;
  final Map<String, dynamic>? favourite;

  CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.breeds,
    this.favourite,
  });
}
