import 'package:alameed_app/core/services/firebase_auth_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/screens/login_screen.dart';

/// محتوى مؤقت بس — هنظبط بنوده الحقيقية (الإعدادات، اللغة، إلخ) بعدين.
/// زرار تسجيل الخروج شغال فعلياً مش placeholder.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                AppImages.logo,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text(LocaleKeys.homeSettings.tr()),
              onTap: () {}, // TODO
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: Text(
                LocaleKeys.homeLogout.tr(),
                style: AppTextStyles.medium(color: AppColors.error),
              ),
              onTap: () async {
                await sl<FirebaseAuthService>().signOut();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
