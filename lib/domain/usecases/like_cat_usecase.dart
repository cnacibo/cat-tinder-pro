import '../repositories/likes_repository.dart';

class LikeCatUseCase {
  final LikesRepository _repository;
  LikeCatUseCase(this._repository);
  Future<void> execute() => _repository.incrementLikes();
}