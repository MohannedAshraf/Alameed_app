import 'package:alameed_app/features/main/presentation/screens/main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/register_bloc.dart';
import '../bloc/register_event.dart';
import '../bloc/register_state.dart';
import '../widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RegisterBloc>(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _nameError = name.trim().length < 2 ? 'common.required_field' : null;
      _emailError = Validators.isValidEmail(email)
          ? null
          : 'common.invalid_email';
      _phoneError = Validators.isValidEgyptPhone(phone)
          ? null
          : 'common.invalid_phone';
      _passwordError = Validators.isValidPassword(password)
          ? null
          : 'common.invalid_password';
      _confirmPasswordError = confirmPassword == password
          ? null
          : 'common.password_mismatch';
    });

    final hasError = [
      _nameError,
      _emailError,
      _phoneError,
      _passwordError,
      _confirmPasswordError,
    ].any((e) => e != null);

    if (!hasError) {
      context.read<RegisterBloc>().add(
        RegisterSubmitted(
          name: name,
          email: email,
          phone: phone,
          password: password,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const  MainScreen()),
            (route) => false,
          );
        } else if (state is RegisterFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messageKey.tr())));
        }
      },
      // مفيش AppBar خالص دلوقتي — يعني مفيش زرار back تلقائي برضو.
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              final isLoading = state is RegisterLoading;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: AppSpacing.md),

                    // ---- اللوجو + العنوان، في النص ----
                    Center(
                      child: Image.asset(
                        AppImages.logo,
                        height: 120.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      LocaleKeys.authRegisterTitle.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading2,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      LocaleKeys.authRegisterSubtitle.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),

                    // ---- باقي الحقول زي ما هي ----
                    CustomTextField(
                      controller: _nameController,
                      hintText: LocaleKeys.authNameHint.tr(),
                      errorText: _nameError?.tr(),
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: AppSpacing.md),
                    CustomTextField(
                      controller: _emailController,
                      hintText: LocaleKeys.authEmailHint.tr(),
                      keyboardType: TextInputType.emailAddress,
                      errorText: _emailError?.tr(),
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: AppSpacing.md),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: LocaleKeys.authPhoneHint.tr(),
                      keyboardType: TextInputType.phone,
                      errorText: _phoneError?.tr(),
                      prefixIcon: Icons.phone_outlined,
                    ),
                    SizedBox(height: AppSpacing.md),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: LocaleKeys.authPasswordHint.tr(),
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
                      onPressed: isLoading ? null : () => _submit(context),
                      child: isLoading
                          ? SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(LocaleKeys.authRegisterButton.tr()),
                    ),
                    SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.authAlreadyHaveAccount.tr(),
                          style: AppTextStyles.body,
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            LocaleKeys.authLoginLink.tr(),
                            style: AppTextStyles.semiBold(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg),
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
