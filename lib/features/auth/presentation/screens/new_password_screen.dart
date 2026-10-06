import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/custom_text_field.dart';

/// UI-only for now — مفيش طلب حقيقي بيغيّر أي حاجة في الباك اند. لما
/// الـ endpoint يجهز، اربط الزرار بيه (هيحتاج widget.email + widget.code
/// + الباسورد الجديد).
class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.email, required this.code});

  final String email;
  final String code;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _passwordError = Validators.isValidPassword(password)
          ? null
          : 'common.invalid_password';
      _confirmPasswordError = confirmPassword == password
          ? null
          : 'common.password_mismatch';
    });

    if (_passwordError == null && _confirmPasswordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(LocaleKeys.authPasswordChangedSuccess.tr())),
      );
      // Login هي أول route في الـ stack (الـ splash والـ onboarding
      // بيستخدموا pushReplacement)، فـ popUntil(isFirst) بيرجعنا لها
      // مباشرة.
      Navigator.of(context).popUntil((route) => route.isFirst);
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
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppSpacing.md),
              Text(
                LocaleKeys.authNewPasswordTitle.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2,
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                LocaleKeys.authNewPasswordSubtitle.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.regular(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSpacing.xl),
              CustomTextField(
                controller: _passwordController,
                hintText: LocaleKeys.authNewPasswordHint.tr(),
                isPassword: true,
                errorText: _passwordError?.tr(),
                prefixIcon: Icons.lock_outline,
              ),
              SizedBox(height: AppSpacing.md),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: LocaleKeys.authConfirmPasswordHint.tr(),
                isPassword: true,
                errorText: _confirmPasswordError?.tr(),
                prefixIcon: Icons.lock_outline,
              ),
              SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: Text(LocaleKeys.authSavePasswordButton.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
