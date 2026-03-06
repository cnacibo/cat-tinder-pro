import '../models/cat_image_model.dart';
import '../models/breed_model.dart';

abstract class CatRemoteDataSource {
  Future<CatImageModel> getRandomCatImage();
  Future<List<BreedModel>> getBreeds();
}