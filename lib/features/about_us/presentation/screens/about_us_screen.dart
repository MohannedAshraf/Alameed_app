import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';

/// TEMPORARY placeholder — هنبنيها بعدين.
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(LocaleKeys.homeAboutUs.tr()),
      ),
      body: Center(
        child: Text(LocaleKeys.homeComingSoon.tr(), style: AppTextStyles.body),
      ),
    );
  }
}
