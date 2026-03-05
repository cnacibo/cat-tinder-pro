import '../entities/cat_image.dart';
import '../repositories/cat_repository.dart';

class GetRandomCat {
  final CatRepository _repository;

  GetRandomCat(this._repository);

  Future<CatImage> execute() {
    return _repository.getRandomCatImage();
  }
}