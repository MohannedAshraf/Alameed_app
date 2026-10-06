import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'new_password_screen.dart';

/// UI-only for now — أي كود طوله 4 أو 6 أرقام بيعدّي. اربطها بالتحقق
/// الحقيقي (وبالـ resend الحقيقي) لما الـ endpoint يجهز.
class ResetPasswordOtpScreen extends StatefulWidget {
  const ResetPasswordOtpScreen({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordOtpScreen> createState() => _ResetPasswordOtpScreenState();
}

class _ResetPasswordOtpScreenState extends State<ResetPasswordOtpScreen> {
  final _codeController = TextEditingController();
  String? _codeError;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _codeController.text.trim();
    setState(() {
      _codeError = (code.length == 4 || code.length == 6)
          ? null
          : 'common.invalid_otp';
    });

    if (_codeError == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => NewPasswordScreen(email: widget.email, code: code),
        ),
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
                LocaleKeys.authOtpTitle.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2,
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                LocaleKeys.authResetOtpSubtitle.tr(
                  namedArgs: {'email': widget.email},
                ),
                textAlign: TextAlign.center,
                style: AppTextStyles.regular(color: AppColors.textSecondary),
              ),
              SizedBox(height: AppSpacing.xl),
              TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 6,
                style: AppTextStyles.heading2.copyWith(letterSpacing: 10.w),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: LocaleKeys.authOtpHint.tr(),
                  errorText: _codeError?.tr(),
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: Text(LocaleKeys.authVerifyButton.tr()),
              ),
              SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.authDidntReceiveCode.tr(),
                    style: AppTextStyles.body,
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(LocaleKeys.authOtpResent.tr())),
                      );
                    },
                    child: Text(
                      LocaleKeys.authResendCode.tr(),
                      style: AppTextStyles.semiBold(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
