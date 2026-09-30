import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/onboarding_page_content.dart';
import '../widgets/onboarding_page_data.dart';
import '../widgets/onboarding_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingBloc>(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatefulWidget {
  const _OnboardingView();

  @override
  State<_OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<_OnboardingView> {
  final _pageController = PageController();
  int _currentIndex = 0;

  // Same logo on all 3 pages for now — swap `image` per item for a real
  // trip photo once the content/UI design is ready.
  static const _pages = [
    OnboardingPageData(
      image: AppImages.logo,
      titleKey: LocaleKeys.onboardingTitle1,
      descriptionKey: LocaleKeys.onboardingDesc1,
    ),
    OnboardingPageData(
      image: AppImages.logo,
      titleKey: LocaleKeys.onboardingTitle2,
      descriptionKey: LocaleKeys.onboardingDesc2,
    ),
    OnboardingPageData(
      image: AppImages.logo,
      titleKey: LocaleKeys.onboardingTitle3,
      descriptionKey: LocaleKeys.onboardingDesc3,
    ),
  ];

  bool get _isLastPage => _currentIndex == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: AppDurations.medium,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemBuilder: (context, index) =>
                    OnboardingPageContent(data: _pages[index]),
              ),

              // Skip — top-right. Hidden on the last page (nothing left
              // to skip once you're already there).
              if (!_isLastPage)
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: TextButton(
                    onPressed: () => context.read<OnboardingBloc>().add(
                      const OnboardingSkipRequested(),
                    ),
                    child: Text(
                      LocaleKeys.onboardingSkip.tr(),
                      style: AppTextStyles.medium(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),

              // Indicator + Next/Get started — bottom.
              Positioned(
                left: 0,
                right: 0,
                bottom: AppSpacing.xl,
                child: Column(
                  children: [
                    OnboardingPageIndicator(
                      pageCount: _pages.length,
                      currentIndex: _currentIndex,
                    ),
                    SizedBox(height: AppSpacing.md),
                    TextButton(
                      onPressed: () {
                        if (_isLastPage) {
                          context.read<OnboardingBloc>().add(
                            const OnboardingFinishRequested(),
                          );
                        } else {
                          _goToNextPage();
                        }
                      },
                      child: Text(
                        _isLastPage
                            ? LocaleKeys.onboardingGetStarted.tr()
                            : LocaleKeys.onboardingNext.tr(),
                        style: AppTextStyles.semiBold(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
