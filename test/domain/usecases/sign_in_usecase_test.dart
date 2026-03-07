import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cat_tinder_pro/domain/repositories/auth_repository.dart';
import 'package:cat_tinder_pro/domain/usecases/sign_in_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInUseCase signInUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(mockAuthRepository);
  });

  group('SignInUseCase', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    test('should return true when signIn succeeds', () async {
      when(() => mockAuthRepository.signIn(testEmail, testPassword))
          .thenAnswer((_) async => true);

      final result = await signInUseCase.execute(testEmail, testPassword);

      expect(result, true);
      verify(() => mockAuthRepository.signIn(testEmail, testPassword)).called(1);
    });

    test('should return false when signIn fails', () async {
      when(() => mockAuthRepository.signIn(testEmail, testPassword))
          .thenAnswer((_) async => false);

      final result = await signInUseCase.execute(testEmail, testPassword);

      expect(result, false);
      verify(() => mockAuthRepository.signIn(testEmail, testPassword)).called(1);
    });
  });
}