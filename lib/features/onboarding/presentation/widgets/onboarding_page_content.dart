import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'onboarding_page_data.dart';

/// One onboarding page's content: image centered, title + description
/// below it. Skip/Next live in the parent screen (shared chrome across
/// all pages), not here.
class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.image, height: 240.h, fit: BoxFit.contain),
          SizedBox(height: AppSpacing.xl),
          Text(
            data.titleKey.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.heading2,
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            data.descriptionKey.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.regular(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
