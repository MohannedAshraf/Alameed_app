import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/otp_bloc.dart';
import '../bloc/otp_event.dart';
import '../bloc/otp_state.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OtpBloc>(),
      child: _OtpView(phone: phone),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView({required this.phone});
  final String phone;

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final _otpController = TextEditingController();
  String? _otpError;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verify(BuildContext context) {
    final otp = _otpController.text;
    setState(() {
      _otpError = otp.trim().length == 4 ? null : 'common.invalid_otp';
    });
    if (_otpError == null) {
      context.read<OtpBloc>().add(
        OtpVerifySubmitted(phone: widget.phone, otp: otp),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpVerifySuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        } else if (state is OtpFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messageKey.tr())));
        } else if (state is OtpResendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(LocaleKeys.authOtpResent.tr())),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
        body: SafeArea(
          child: BlocBuilder<OtpBloc, OtpState>(
            builder: (context, state) {
              final isVerifying = state is OtpVerifying;
              final isResending = state is OtpResending;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: AppSpacing.md),
                    Text(
                      LocaleKeys.authOtpTitle.tr(),
                      style: AppTextStyles.heading2,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      LocaleKeys.authOtpSubtitle.tr(
                        namedArgs: {'phone': widget.phone},
                      ),
                      style: AppTextStyles.regular(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xl),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      style: AppTextStyles.heading2.copyWith(
                        letterSpacing: 12.w,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: LocaleKeys.authOtpHint.tr(),
                        errorText: _otpError?.tr(),
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    ElevatedButton(
                      onPressed: isVerifying ? null : () => _verify(context),
                      child: isVerifying
                          ? SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(LocaleKeys.authVerifyButton.tr()),
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
                          onPressed: isResending
                              ? null
                              : () => context.read<OtpBloc>().add(
                                  OtpResendRequested(phone: widget.phone),
                                ),
                          child: Text(
                            LocaleKeys.authResendCode.tr(),
                            style: AppTextStyles.semiBold(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
