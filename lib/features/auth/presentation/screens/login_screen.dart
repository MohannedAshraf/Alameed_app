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
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_login_button.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitEmailLogin(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _emailError = Validators.isValidEmail(email)
          ? null
          : 'common.invalid_email';
      _passwordError = Validators.isValidPassword(password)
          ? null
          : 'common.invalid_password';
    });

    if (_emailError == null && _passwordError == null) {
      context.read<LoginBloc>().add(
        LoginWithEmailSubmitted(email: email, password: password),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const  MainScreen()),
            (route) => false,
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.messageKey.tr())));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              final isLoading = state is LoginLoading;

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
                      LocaleKeys.authWelcomeBack.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading2,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      LocaleKeys.authLoginSubtitle.tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.regular(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xl),

                    // ---- حقول الإيميل/الباسورد بس، مفيش تابات خالص ----
                    CustomTextField(
                      controller: _emailController,
                      hintText: LocaleKeys.authEmailHint.tr(),
                      keyboardType: TextInputType.emailAddress,
                      errorText: _emailError?.tr(),
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: AppSpacing.md),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: LocaleKeys.authPasswordHint.tr(),
                      isPassword: true,
                      errorText: _passwordError?.tr(),
                      prefixIcon: Icons.lock_outline,
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          LocaleKeys.authForgotPassword.tr(),
                          style: AppTextStyles.medium(color: AppColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () => _submitEmailLogin(context),
                      child: isLoading
                          ? SizedBox(
                              height: 20.h,
                              width: 20.h,
                              child: const CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(LocaleKeys.authLoginButton.tr()),
                    ),

                    SizedBox(height: AppSpacing.lg),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                          ),
                          child: Text(
                            LocaleKeys.authOrContinueWith.tr(),
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg),
                    SocialLoginButton(
                      icon: const Icon(Icons.g_mobiledata_rounded, size: 26),
                      label: LocaleKeys.authContinueWithGoogle.tr(),
                      onPressed: isLoading
                          ? () {}
                          : () => context.read<LoginBloc>().add(
                              const LoginWithGoogleRequested(),
                            ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    SocialLoginButton(
                      icon: const Icon(Icons.apple, size: 22),
                      label: LocaleKeys.authContinueWithApple.tr(),
                      onPressed: isLoading
                          ? () {}
                          : () => context.read<LoginBloc>().add(
                              const LoginWithAppleRequested(),
                            ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LocaleKeys.authNoAccount.tr(),
                          style: AppTextStyles.body,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            LocaleKeys.authCreateAccount.tr(),
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
