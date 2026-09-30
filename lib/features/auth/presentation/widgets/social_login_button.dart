import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Outlined button for Google / Apple sign-in. Takes any icon widget for
/// now (Material icon placeholder) — swap for the real Google "G" logo
/// (AppIcons.google, already reserved) once flutter_svg + the asset exist.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final Widget icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        label,
        style: AppTextStyles.medium(color: AppColors.textPrimary),
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 52.h),
        side: const BorderSide(color: AppColors.greyLight),
      ),
    );
  }
}
