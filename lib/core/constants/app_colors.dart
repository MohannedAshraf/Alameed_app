import 'package:flutter/material.dart';

/// Every color used in the app lives here — never hardcode `Color(0xFF...)`
/// inside a screen or widget. If the design file (once ready) changes a
/// color, this is the only file that needs to change.
///
/// primary / secondary are extracted directly from the EL-AMEED TRAVEL logo.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------
  // Brand colors (from logo)
  // ---------------------------------------------------------------------
  static const Color primary = Color(0xFF0C4698); // navy blue
  static const Color secondary = Color(0xFFF69802); // orange / amber

  // Shades — for hover/pressed states, gradients, disabled buttons, etc.
  static const Color primaryDark = Color(0xFF08316B);
  static const Color primaryLight = Color(0xFF5E7CA8);
  static const Color primaryExtraLight = Color(0xFFE6ECF6);

  static const Color secondaryDark = Color(0xFFC97B00);
  static const Color secondaryLight = Color(0xFFFFC266);
  static const Color secondaryExtraLight = Color(0xFFFDF0DC);

  // ---------------------------------------------------------------------
  // Neutrals
  // ---------------------------------------------------------------------
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color scaffoldBackground = Color(0xFFF7F8FA);
  static const Color greyDark = Color(0xFF4D4D4D);
  static const Color grey = Color(0xFF9AA0A6);
  static const Color greyLight = Color(0xFFE1E4E8);
  static const Color divider = Color(0xFFE5E8EB);

  // ---------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------
  static const Color textPrimary = Color(0xFF1D2733);
  static const Color textSecondary = Color(0xFF5B6B78);
  static const Color textHint = Color(0xFFA0A7AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFF1D2733);

  // ---------------------------------------------------------------------
  // Feedback
  // ---------------------------------------------------------------------
  static const Color success = Color(0xFF2E9E5B);
  static const Color error = Color(0xFFE0433D);
  static const Color warning = Color(0xFFF6A609);
  static const Color info = Color(0xFF2E7CD6);

  // ---------------------------------------------------------------------
  // Overlays / misc
  // ---------------------------------------------------------------------
  static const Color overlay = Color(0x99000000); // black @ 60%
  static const Color shimmerBase = Color(0xFFE8E8E8);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
}
