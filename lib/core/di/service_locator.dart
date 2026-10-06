import 'package:alameed_app/core/services/firebase_auth_services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/local_storage_service.dart';
import '../../features/splash/data/datasources/splash_local_data_source.dart';
import '../../features/splash/data/repositories/splash_repository_impl.dart';
import '../../features/splash/domain/repositories/splash_repository.dart';
import '../../features/splash/domain/usecases/get_onboarding_seen_usecase.dart';
import '../../features/onboarding/data/datasources/onboarding_local_data_source.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_with_apple_usecase.dart';
import '../../features/auth/domain/usecases/login_with_email_usecase.dart';
import '../../features/auth/domain/usecases/login_with_google_usecase.dart';
import '../../features/auth/domain/usecases/register_with_email_usecase.dart';
import '../../features/auth/domain/usecases/send_otp_usecase.dart';
import '../../features/auth/domain/usecases/verify_otp_usecase.dart';
import '../../features/auth/presentation/bloc/login_bloc.dart';
import '../../features/auth/presentation/bloc/otp_bloc.dart';
import '../../features/auth/presentation/bloc/register_bloc.dart';

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
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

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
  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc(sl()));

  // ---- Auth feature (login / register / otp) ----
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<LoginWithEmailUseCase>(
    () => LoginWithEmailUseCase(sl()),
  );
  sl.registerLazySingleton<SendOtpUseCase>(() => SendOtpUseCase(sl()));
  sl.registerLazySingleton<VerifyOtpUseCase>(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton<RegisterWithEmailUseCase>(
    () => RegisterWithEmailUseCase(sl()),
  );
  sl.registerLazySingleton<LoginWithGoogleUseCase>(
    () => LoginWithGoogleUseCase(sl()),
  );
  sl.registerLazySingleton<LoginWithAppleUseCase>(
    () => LoginWithAppleUseCase(sl()),
  );
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory<RegisterBloc>(() => RegisterBloc(sl()));
  sl.registerFactory<OtpBloc>(() => OtpBloc(sl(), sl()));
}
