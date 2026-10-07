import 'package:alameed_app/core/services/firebase_auth_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/widgets/custom_text_field.dart';

/// الاسم بيتحدث فعلياً في Firebase (updateDisplayName). رقم الموبايل
/// UI بس دلوقتي — مفيش له مكان حقيقي يتخزن فيه لسه. الإيميل للعرض بس
/// (تغييره محتاج إعادة تحقق reauthenticate، هنضيفها كـ flow منفصل بعدين).
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  String? _nameError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final user = sl<FirebaseAuthService>().currentUser;
    _nameController = TextEditingController(text: user?.displayName ?? '');
    _phoneController = TextEditingController(text: user?.phoneNumber ?? '');
    _emailController = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    setState(
      () => _nameError = name.length < 2 ? 'common.required_field' : null,
    );
    if (_nameError != null) return;

    setState(() => _isSaving = true);
    try {
      final user = sl<FirebaseAuthService>().currentUser;
      await user?.updateDisplayName(name);
      await user?.reload();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(LocaleKeys.profileUpdated.tr())));
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(LocaleKeys.commonSomethingWentWrong.tr())),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(LocaleKeys.profileEditProfile.tr()),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                controller: _nameController,
                hintText: LocaleKeys.authNameHint.tr(),
                errorText: _nameError?.tr(),
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: AppSpacing.md),
              CustomTextField(
                controller: _phoneController,
                hintText: LocaleKeys.authPhoneHint.tr(),
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone_outlined,
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                LocaleKeys.profilePhoneNotSaved.tr(),
                style: AppTextStyles.caption,
              ),
              SizedBox(height: AppSpacing.lg),
              CustomTextField(
                controller: _emailController,
                hintText: LocaleKeys.authEmailHint.tr(),
                prefixIcon: Icons.email_outlined,
                enabled: false,
              ),
              SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(LocaleKeys.profileSave.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
