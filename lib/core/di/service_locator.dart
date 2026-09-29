import 'package:alameed_app/features/splash/data/datasources/plash_local_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/local_storage_service.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/get_onboarding_seen_usecase.dart';
import '../../features/onboarding/data/datasources/onboarding_local_data_source.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';

final sl = GetIt.instance;

/// Called once in main() before runApp. Every new feature registers its
/// data source -> repository -> usecases (and bloc, as a factory) here.
Future<void> setupServiceLocator() async {
  // ---- Core ----
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(sl()),
  );

  // ---- Splash feature ----
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSource(sl()),
  );
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl(sl()));
  sl.registerLazySingleton<GetOnboardingSeenUseCase>(
    () => GetOnboardingSeenUseCase(sl()),
  );

  // ---- Onboarding feature ----
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSource(sl()),
  );
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CompleteOnboardingUseCase>(
    () => CompleteOnboardingUseCase(sl()),
  );
  // Factory (not singleton) — bloc holds screen-level state, we want a
  // fresh instance each time OnboardingScreen is built.
  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc(sl()));
}
