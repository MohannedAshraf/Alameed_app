import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../login/presentation/screens/login_screen.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(sl())..add(const SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashFinished) {
            final target = state.destination == SplashDestination.login
                ? const LoginScreen()
                : const OnboardingScreen();

            Navigator.of(
              context,
            ).pushReplacement(MaterialPageRoute(builder: (_) => target));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Center(
            child: Image(image: const AssetImage(AppImages.logo), width: 180.w),
          ),
        ),
      ),
    );
  }
}
