import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Use cases
import '../domain/usecases/get_random_cat_usecase.dart';
import '../domain/usecases/get_breeds_usecase.dart';
import '../domain/usecases/sign_in_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';
import '../domain/usecases/get_likes_count_usecase.dart';
import '../domain/usecases/like_cat_usecase.dart';
import '../domain/usecases/reset_likes_usecase.dart';

// Data sources
import '../data/datasources/auth_remote_datasource.dart';
import '../data/datasources/cat_remote_datasource.dart';
import '../data/datasources/auth_remote_datasource_impl.dart';
import '../data/datasources/cat_remote_datasource_impl.dart';
import '../data/datasources/likes_local_datasource.dart';
import '../data/datasources/likes_local_datasource_impl.dart';

// Repositories
import '../domain/repositories/auth_repository.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/cat_repository.dart';
import '../data/repositories/cat_repository_impl.dart';
import '../domain/repositories/likes_repository.dart';
import '../data/repositories/likes_repository_impl.dart';


final getIt = GetIt.instance;

Future<void> init({String? catApiKey}) async {
  // External 
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  getIt.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: getIt()),
  );
  getIt.registerLazySingleton<CatRemoteDataSource>(
    () => CatRemoteDataSourceImpl(httpClient: getIt(), apiKey: catApiKey),
  );
  getIt.registerLazySingleton<LikesLocalDataSource>(
  () => LikesLocalDataSourceImpl(sharedPreferences: getIt()),
);

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<CatRepository>(
    () => CatRepositoryImpl(apiService: getIt()),
  );
  getIt.registerLazySingleton<LikesRepository>(
    () => LikesRepositoryImpl(localDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRandomCatUseCase(getIt()));
  getIt.registerLazySingleton(() => GetBreedsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetLikesCountUseCase(getIt()));
  getIt.registerLazySingleton(() => LikeCatUseCase(getIt()));
  getIt.registerLazySingleton(() => ResetLikesUseCase(getIt()));

}