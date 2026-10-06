import 'package:alameed_app/features/splash/data/datasources/splash_local_data_source.dart';

import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  SplashRepositoryImpl(this._localDataSource);

  final SplashLocalDataSource _localDataSource;

  @override
  bool hasSeenOnboarding() => _localDataSource.hasSeenOnboarding();
}
