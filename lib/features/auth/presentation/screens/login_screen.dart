import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_login_button.dart';
import 'otp_screen.dart';
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

class _LoginViewState extends State<_LoginView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // IndexedStack مش متزامن تلقائي مع TabController زي TabBarView —
    // لازم نسمعله يدوي ونعمل rebuild كل ما التبويب يتغيّر.
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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

  void _submitPhoneLogin(BuildContext context) {
    final phone = _phoneController.text;

    setState(() {
      _phoneError = Validators.isValidEgyptPhone(phone)
          ? null
          : 'common.invalid_phone';
    });

    if (_phoneError == null) {
      context.read<LoginBloc>().add(LoginSendOtpSubmitted(phone: phone));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          );
        } else if (state is LoginOtpSent) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => OtpScreen(phone: state.phone)),
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
                    SizedBox(height: AppSpacing.xl),
                    Text(
                      LocaleKeys.authWelcomeBack.tr(),
                      style: AppTextStyles.heading2,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      LocaleKeys.authLoginSubtitle.tr(),
                      style: AppTextStyles.regular(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primary,
                      unselectedLabelColor: AppColors.textSecondary,
                      indicatorColor: AppColors.primary,
                      labelStyle: AppTextStyles.semiBold(fontSize: 14),
                      tabs: [
                        Tab(text: LocaleKeys.authEmailTab.tr()),
                        Tab(text: LocaleKeys.authPhoneTab.tr()),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg),

                    // IndexedStack بيكبّر لحجم أطول تبويب تلقائي — مفيش
                    // ارتفاع ثابت نحتاج نضبطه يدوي، فمفيش overflow.
                    IndexedStack(
                      index: _tabController.index,
                      children: [
                        // ---- Email tab ----
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                onPressed: () {}, // TODO: forgot-password flow
                                child: Text(
                                  LocaleKeys.authForgotPassword.tr(),
                                  style: AppTextStyles.medium(
                                    color: AppColors.primary,
                                  ),
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
                          ],
                        ),

                        // ---- Phone tab ----
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: _phoneController,
                              hintText: LocaleKeys.authPhoneHint.tr(),
                              keyboardType: TextInputType.phone,
                              errorText: _phoneError?.tr(),
                              prefixIcon: Icons.phone_outlined,
                            ),
                            SizedBox(height: AppSpacing.lg),
                            ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () => _submitPhoneLogin(context),
                              child: isLoading
                                  ? SizedBox(
                                      height: 20.h,
                                      width: 20.h,
                                      child: const CircularProgressIndicator(
                                        color: AppColors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(LocaleKeys.authSendCode.tr()),
                            ),
                          ],
                        ),
                      ],
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
