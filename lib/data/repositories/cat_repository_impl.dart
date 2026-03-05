import '../../domain/repositories/cat_repository.dart';
import '../models/cat_image_model.dart';
import '../models/breed_model.dart';
import '../sources/cat_api_service.dart';

class CatRepositoryImpl implements CatRepository {
  final CatApiService catApiService;

  CatRepositoryImpl({required this.catApiService});

  @override
  Future<CatImageModel> getRandomCatImage() async {
    try {
      final catModel = await catApiService.getRandomCatImage();
      return catModel; 
    } catch (e) {
      throw Exception('Failed to get random cat: $e');
    }
  }
  
  @override
  Future<List<BreedModel>> getBreeds() async {
    try {
      final breedModels = await catApiService.getBreeds();
      return breedModels; 
    } catch (e) {
      throw Exception('Failed to get breeds: $e');
    }
  }
}