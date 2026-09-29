/// Every SharedPreferences key lives here — never write a raw string
/// like 'has_seen_onboarding' inside a data source.
class StorageKeys {
  StorageKeys._();

  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String authToken = 'auth_token'; // هنستخدمه لما نبني الـ login
}
