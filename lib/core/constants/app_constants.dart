import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Reusable spacing, radius, and animation values — so every screen uses
/// the same rhythm instead of random EdgeInsets.all(17) here and there.
/// Values are plain doubles; apply .w/.h/.r/.sp where you use them.
class AppSpacing {
  AppSpacing._();

  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 16.w;
  static double get lg => 24.w;
  static double get xl => 32.w;
  static double get xxl => 48.w;
}

class AppRadius {
  AppRadius._();

  static double get sm => 8.r;
  static double get md => 12.r;
  static double get lg => 16.r;
  static double get xl => 24.r;
  static double get circular => 999.r;
}

class AppDurations {
  AppDurations._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 600);

  /// Splash screen duration. Product spec: 5 seconds max — keep this
  /// at or under Duration(seconds: 5).
  static const Duration splashDuration = Duration(seconds: 3);
}
