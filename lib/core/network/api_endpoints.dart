/// Every backend route lives here. When a feature's remote data source
/// needs a URL, it imports this file instead of typing the string itself —
/// one typo fixed in one place instead of five.
class ApiEndpoints {
  ApiEndpoints._();

  // TODO: replace with the real base URL once the backend gives it to you.
  // Keep it out of version control for prod (use --dart-define or .env).
  static const String baseUrl = 'https://api.elameedtravel.com/api/v1';

  // ---- Auth ----
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';

  // ---- App config / onboarding ----
  static const String appConfig = '/config';

  // Add each new feature's endpoints below, grouped with a comment,
  // e.g.:
  // ---- Trips ----
  // static const String trips = '/trips';
  // static String tripDetails(String id) => '/trips/$id';
}
