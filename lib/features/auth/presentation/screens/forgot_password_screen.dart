import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/custom_text_field.dart';
import 'reset_password_otp_screen.dart';

/// UI-only for now — لسه مفيش أي طلب حقيقي بيروح لحد. لما الباك اند
/// يضيف endpoint لـ "forgot password"، اربط زرار الإرسال بيه بدل ما
/// يروح على طول لـ ResetPasswordOtpScreen.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _emailError;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    final email = _emailController.text;
    setState(() {
      _emailError = Validators.isValidEmail(email)
          ? null
          : 'common.invalid_email';
    });

    if (_emailError == null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ResetPasswordOtpScreen(email: email)),
      );
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
                LocaleKeys.authForgotPassword.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2,
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                LocaleKeys.authForgotPasswordSubtitle.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.regular(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSpacing.xl),
              CustomTextField(
                controller: _emailController,
                hintText: LocaleKeys.authEmailHint.tr(),
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError?.tr(),
                prefixIcon: Icons.email_outlined,
              ),
              SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: Text(LocaleKeys.authSendCode.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
