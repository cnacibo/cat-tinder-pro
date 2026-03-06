import '../repositories/likes_repository.dart';

class GetLikesCountUseCase {
  final LikesRepository _repository;
  GetLikesCountUseCase(this._repository);
  Future<int> execute() => _repository.getLikesCount();
}