import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cat_tinder_pro/core/injection.dart' as di;
import 'package:cat_tinder_pro/domain/usecases/sign_in_usecase.dart';
import 'package:cat_tinder_pro/domain/usecases/sign_up_usecase.dart';
import 'package:cat_tinder_pro/presentation/auth/auth_screen.dart';

import 'package:cat_tinder_pro/domain/usecases/get_random_cat_usecase.dart';
import 'package:cat_tinder_pro/domain/usecases/get_likes_count_usecase.dart';
import 'package:cat_tinder_pro/domain/usecases/like_cat_usecase.dart';
import 'package:cat_tinder_pro/domain/usecases/reset_likes_usecase.dart';
import 'package:cat_tinder_pro/domain/usecases/get_breeds_usecase.dart';
import 'package:cat_tinder_pro/domain/entities/cat_image.dart';
import 'package:cat_tinder_pro/domain/entities/breed.dart';

import 'package:cat_tinder_pro/core/analytics/analytics_service.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}
class MockSignUpUseCase extends Mock implements SignUpUseCase {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockGetRandomCatUseCase extends Mock implements GetRandomCatUseCase {}
class MockGetLikesCountUseCase extends Mock implements GetLikesCountUseCase {}
class MockLikeCatUseCase extends Mock implements LikeCatUseCase {}
class MockResetLikesUseCase extends Mock implements ResetLikesUseCase {}
class MockGetBreedsUseCase extends Mock implements GetBreedsUseCase {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  late MockSignInUseCase mockSignInUseCase;
  late MockSignUpUseCase mockSignUpUseCase;
  late MockNavigatorObserver mockObserver;

  late MockGetRandomCatUseCase mockGetRandomCatUseCase;
  late MockGetLikesCountUseCase mockGetLikesCountUseCase;
  late MockLikeCatUseCase mockLikeCatUseCase;
  late MockResetLikesUseCase mockResetLikesUseCase;
  late MockGetBreedsUseCase mockGetBreedsUseCase;

  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockSignUpUseCase = MockSignUpUseCase();
    mockObserver = MockNavigatorObserver();

    mockGetRandomCatUseCase = MockGetRandomCatUseCase();
    mockGetLikesCountUseCase = MockGetLikesCountUseCase();
    mockLikeCatUseCase = MockLikeCatUseCase();
    mockResetLikesUseCase = MockResetLikesUseCase();
    mockGetBreedsUseCase = MockGetBreedsUseCase();

    mockAnalyticsService = MockAnalyticsService();

    di.getIt.reset();

    di.getIt.registerFactory<SignInUseCase>(() => mockSignInUseCase);
    di.getIt.registerFactory<SignUpUseCase>(() => mockSignUpUseCase);

    di.getIt.registerFactory<GetRandomCatUseCase>(() => mockGetRandomCatUseCase);
    di.getIt.registerFactory<GetLikesCountUseCase>(() => mockGetLikesCountUseCase);
    di.getIt.registerFactory<LikeCatUseCase>(() => mockLikeCatUseCase);
    di.getIt.registerFactory<ResetLikesUseCase>(() => mockResetLikesUseCase);
    di.getIt.registerFactory<GetBreedsUseCase>(() => mockGetBreedsUseCase);

    di.getIt.registerSingleton<AnalyticsService>(mockAnalyticsService);

    registerFallbackValue('');

    registerFallbackValue(MaterialPageRoute(builder: (_) => const SizedBox()));

    when(() => mockSignInUseCase.execute(any(), any())).thenAnswer((_) async => false);
    when(() => mockSignUpUseCase.execute(any(), any())).thenAnswer((_) async => false);

    when(() => mockGetRandomCatUseCase.execute()).thenAnswer((_) async => CatImage(id: 'test', breeds: [], url: '', width: 0, height: 0));
    when(() => mockGetLikesCountUseCase.execute()).thenAnswer((_) async => 0);
    when(() => mockLikeCatUseCase.execute()).thenAnswer((_) async => {});
    when(() => mockResetLikesUseCase.execute()).thenAnswer((_) async => {});
    when(() => mockGetBreedsUseCase.execute()).thenAnswer((_) async => <Breed>[]);

    when(() => mockAnalyticsService.logSignIn(any())).thenAnswer((_) async => Future.value());
    when(() => mockAnalyticsService.logSignUp(any())).thenAnswer((_) async => Future.value());
    when(() => mockAnalyticsService.logSignInFailed(any(), any()))
        .thenAnswer((_) async => Future.value());
    when(() => mockAnalyticsService.logSignUpFailed(any(), any()))
        .thenAnswer((_) async => Future.value());
    when(() => mockAnalyticsService.logLogout()).thenAnswer((_) async => Future.value());
  });

  tearDown(() {
    di.getIt.reset();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: const AuthScreen(),
      navigatorObservers: [mockObserver],
    );
  }

  group('AuthScreen', () {
      testWidgets('should show error when email is invalid', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'invalid-email');

      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.tap(loginButton);
      await tester.pump(); 

      expect(find.text('Invalid email'), findsOneWidget);

      verifyNever(() => mockSignInUseCase.execute(any(), any()));
    });

    testWidgets('should navigate to home if login is successful', (tester) async {
      when(() => mockSignInUseCase.execute('test@gmail.com', 'password')).thenAnswer((_) async => true);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;

      await tester.enterText(emailField, 'test@gmail.com');
      await tester.enterText(passwordField, 'password');

      final loginButton = find.widgetWithText(ElevatedButton, 'Login');
      await tester.tap(loginButton);
      await tester.pump();

      verify(() => mockSignInUseCase.execute('test@gmail.com', 'password')).called(1);

      verify(() => mockObserver.didReplace(
        oldRoute: any(named: 'oldRoute'),
        newRoute: any(named: 'newRoute'),
      )).called(1);
    });
  });
}