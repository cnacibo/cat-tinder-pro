import '../entities/cat_image.dart';
import '../repositories/cat_repository.dart';

class GetRandomCatUseCase {
  final CatRepository _repository;

  GetRandomCatUseCase(this._repository);

  Future<CatImage> execute() {
    return _repository.getRandomCatImage();
  }
}