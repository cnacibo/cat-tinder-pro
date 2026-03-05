import '../entities/cat_image.dart';
import '../entities/breed.dart';

abstract class CatRepository {
  Future<CatImage> getRandomCatImage();
  Future<List<Breed>> getBreeds();
}