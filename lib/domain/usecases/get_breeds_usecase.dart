import '../entities/breed.dart';
import '../repositories/cat_repository.dart';

class GetBreedsUseCase {
  final CatRepository _repository;

  GetBreedsUseCase(this._repository);

  Future<List<Breed>> execute() {
    return _repository.getBreeds();
  }
}