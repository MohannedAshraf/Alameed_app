import 'package:alameed_app/core/services/firebase_auth_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../about_us/presentation/screens/about_us_screen.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../favourites/presentation/screens/favourites_screen.dart';
import '../../../help/presentation/screens/help_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

/// التلت الأول (صورة + اسم) حقيقي من Firebase. باقي البنود (ما عدا
/// تسجيل الخروج) بتودّي لصفحات placeholder لحد ما نبنيها.
/// onNavigateToTab بينقل لتاب "رحلاتي" في الـ Bottom Nav بدل ما يفتح
/// صفحة منفصلة.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.onNavigateToTab});

  final ValueChanged<int> onNavigateToTab;

  @override
  Widget build(BuildContext context) {
    final user = sl<FirebaseAuthService>().currentUser;

    return Drawer(
      child: Column(
        children: [
          // ---- التلت الأول: primary color، صورة + اسم، كله في النص ----
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: AppColors.primary,
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // أيقونة placeholder دلوقتي — هتتحول تلقائي لصورة
                    // حقيقية لو عند المستخدم photoURL (زي حسابات جوجل).
                    CircleAvatar(
                      radius: 36.r,
                      backgroundColor: AppColors.white,
                      backgroundImage: (user?.photoURL != null)
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? Icon(
                              Icons.person,
                              size: 36.sp,
                              color: AppColors.primary,
                            )
                          : null,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      (user?.displayName?.isNotEmpty ?? false)
                          ? user!.displayName!
                          : (user?.email ?? ''),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.semiBold(
                        fontSize: 15,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ---- التلتين اللي تحت: أبيض، كل عنصر في النص ----
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.white,
              child: Column(
                children: [
                  SizedBox(height: AppSpacing.sm),
                  _DrawerItem(
                    icon: Icons.favorite_border,
                    label: LocaleKeys.homeFavourites.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FavouritesScreen(),
                        ),
                      );
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.card_travel_outlined,
                    label: LocaleKeys.navMyTrips.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavigateToTab(2);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.settings_outlined,
                    label: LocaleKeys.homeSettings.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.info_outline,
                    label: LocaleKeys.homeAboutUs.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AboutUsScreen(),
                        ),
                      );
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.help_outline,
                    label: LocaleKeys.homeHelp.tr(),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HelpScreen()),
                      );
                    },
                  ),
                  const Spacer(),
                  const Divider(height: 1),
                  _DrawerItem(
                    icon: Icons.logout,
                    label: LocaleKeys.homeLogout.tr(),
                    color: AppColors.error,
                    onTap: () async {
                      await sl<FirebaseAuthService>().signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                  SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20.sp, color: color ?? AppColors.textPrimary),
            SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTextStyles.medium(
                color: color ?? AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
