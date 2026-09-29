import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/local_storage_service.dart';

class OnboardingLocalDataSource {
  OnboardingLocalDataSource(this._localStorage);

  final LocalStorageService _localStorage;

  Future<void> markOnboardingSeen() =>
      _localStorage.setBool(StorageKeys.hasSeenOnboarding, true);
}
