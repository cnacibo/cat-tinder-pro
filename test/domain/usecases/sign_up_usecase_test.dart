import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cat_tinder_pro/domain/repositories/auth_repository.dart';
import 'package:cat_tinder_pro/domain/usecases/sign_up_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignUpUseCase signUpUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signUpUseCase = SignUpUseCase(mockAuthRepository);
  });

  group('SignUpUseCase', () {
    const testEmail = 'test@gmail.com';
    const testPassword = 'password123';

    test('should return true when signUp succeeds', () async {
      when(() => mockAuthRepository.signUp(testEmail, testPassword))
          .thenAnswer((_) async => true);

      final result = await signUpUseCase.execute(testEmail, testPassword);

      expect(result, true);
      verify(() => mockAuthRepository.signUp(testEmail, testPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

     test('should return false when signUp fails', () async {
      when(() => mockAuthRepository.signUp(testEmail, testPassword))
          .thenAnswer((_) async => false);

      final result = await signUpUseCase.execute(testEmail, testPassword);

      expect(result, false);
      verify(() => mockAuthRepository.signUp(testEmail, testPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
    
  });
}