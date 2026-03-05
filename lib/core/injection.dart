import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../domain/usecases/get_random_cat.dart';
import '../domain/usecases/sign_in_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';

// Data sources
import '../../data/sources/auth_remote_datasource.dart';

// Repositories (абстракции и реализации)
import '../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/cat_repository.dart';
import '../../data/repositories/cat_repository_impl.dart';


final getIt = GetIt.instance;

Future<void> init() async {
  // External 
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);

  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  // getIt.registerLazySingleton(() => GetRandomCat(getIt()));

  // Data sources

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: getIt<FirebaseAuth>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );

}