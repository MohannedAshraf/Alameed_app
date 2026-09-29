abstract class OnboardingRepository {
  /// Persists that the user finished (or skipped) onboarding, so splash
  /// never shows it to them again.
  Future<void> completeOnboarding();
}
