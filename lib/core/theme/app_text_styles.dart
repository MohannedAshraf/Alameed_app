import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

/// All text styles, built with .sp so they scale with ScreenUtil.
/// These are getters (not `static final`) on purpose — ScreenUtil isn't
/// initialized yet when this class first loads, so computing .sp lazily
/// on each access avoids "ScreenUtil not initialized" crashes.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    Color color = AppColors.textPrimary,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static TextStyle regular({
    double fontSize = 14,
    Color color = AppColors.textPrimary,
    double? height,
  }) => _base(
    fontSize: fontSize,
    fontWeight: FontWeight.w400,
    color: color,
    height: height,
  );

  static TextStyle medium({
    double fontSize = 14,
    Color color = AppColors.textPrimary,
    double? height,
  }) => _base(
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    color: color,
    height: height,
  );

  static TextStyle semiBold({
    double fontSize = 14,
    Color color = AppColors.textPrimary,
    double? height,
  }) => _base(
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    color: color,
    height: height,
  );

  static TextStyle bold({
    double fontSize = 14,
    Color color = AppColors.textPrimary,
    double? height,
  }) => _base(
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    color: color,
    height: height,
  );

  // -------------------------------------------------------------------
  // Presets — use these in screens/widgets instead of calling the
  // builders above directly, so text sizes stay consistent app-wide.
  // -------------------------------------------------------------------
  static TextStyle get heading1 => bold(fontSize: 28);
  static TextStyle get heading2 => bold(fontSize: 22);
  static TextStyle get title => semiBold(fontSize: 18);
  static TextStyle get subtitle =>
      medium(fontSize: 16, color: AppColors.textSecondary);
  static TextStyle get body => regular(fontSize: 14);
  static TextStyle get bodySmall =>
      regular(fontSize: 12, color: AppColors.textSecondary);
  static TextStyle get caption =>
      regular(fontSize: 11, color: AppColors.textHint);
  static TextStyle get button =>
      semiBold(fontSize: 16, color: AppColors.textOnPrimary);
}
