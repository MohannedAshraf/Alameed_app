import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/local_storage_service.dart';

class SplashLocalDataSource {
  SplashLocalDataSource(this._localStorage);

  final LocalStorageService _localStorage;

  bool hasSeenOnboarding() =>
      _localStorage.getBool(StorageKeys.hasSeenOnboarding);
}
