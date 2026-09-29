import '../repositories/splash_repository.dart';

class GetOnboardingSeenUseCase {
  GetOnboardingSeenUseCase(this._repository);

  final SplashRepository _repository;

  bool call() => _repository.hasSeenOnboarding();
}
