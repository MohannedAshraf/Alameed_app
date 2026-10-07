import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/services/firebase_auth_services.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'edit_profile_screen.dart';

/// الشكل الأساسي بس دلوقتي. الاسم والإيميل والصورة حقيقيين من Firebase.
/// رقم الموبايل لسه مش متخزن في أي مكان حقيقي (محتاج باك اند/Firestore
/// لاحقاً) — شايله هنا كعرض بس.
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final user = sl<FirebaseAuthService>().currentUser;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          SizedBox(height: AppSpacing.md),
          CircleAvatar(
            radius: 48.r,
            backgroundColor: AppColors.primaryExtraLight,
            backgroundImage: (user?.photoURL != null)
                ? NetworkImage(user!.photoURL!)
                : null,
            child: user?.photoURL == null
                ? Icon(Icons.person, size: 48.sp, color: AppColors.primary)
                : null,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            (user?.displayName?.isNotEmpty ?? false) ? user!.displayName! : '—',
            style: AppTextStyles.heading2,
          ),
          SizedBox(height: AppSpacing.xs),
          Text(
            user?.email ?? '',
            style: AppTextStyles.regular(color: AppColors.textSecondary),
          ),
          SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
            icon: const Icon(Icons.edit_outlined),
            label: Text(LocaleKeys.profileEditProfile.tr()),
          ),
          SizedBox(height: AppSpacing.xl),
          _ProfileInfoTile(
            icon: Icons.email_outlined,
            label: LocaleKeys.authEmailHint.tr(),
            value: user?.email ?? '—',
          ),
          _ProfileInfoTile(
            icon: Icons.phone_outlined,
            label: LocaleKeys.authPhoneHint.tr(),
            value: (user?.phoneNumber?.isNotEmpty ?? false)
                ? user!.phoneNumber!
                : '—',
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoTile extends StatelessWidget {
  const _ProfileInfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.textSecondary),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                Text(value, style: AppTextStyles.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
