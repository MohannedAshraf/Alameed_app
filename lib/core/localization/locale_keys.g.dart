// This file mirrors assets/translations/en.json and ar.json.
//
// It is written by hand right now to match the two starter files above.
// Once easy_localization is added to pubspec.yaml, you can regenerate it
// automatically after adding new keys with:
//
//   flutter pub run easy_localization:generate -f keys \
//     -S assets/translations -O lib/core/localization -o locale_keys.g.dart
//
// Usage in a widget: Text(LocaleKeys.onboardingSkip.tr())

abstract class LocaleKeys {
  static const appName = 'app_name';

  // onboarding.*
  static const onboardingTitle1 = 'onboarding.title_1';
  static const onboardingDesc1 = 'onboarding.desc_1';
  static const onboardingTitle2 = 'onboarding.title_2';
  static const onboardingDesc2 = 'onboarding.desc_2';
  static const onboardingTitle3 = 'onboarding.title_3';
  static const onboardingDesc3 = 'onboarding.desc_3';
  static const onboardingSkip = 'onboarding.skip';
  static const onboardingNext = 'onboarding.next';
  static const onboardingGetStarted = 'onboarding.get_started';

  // common.*
  static const commonOk = 'common.ok';
  static const commonCancel = 'common.cancel';
  static const commonRetry = 'common.retry';
  static const commonLoading = 'common.loading';
  static const commonNoInternet = 'common.no_internet';
  static const commonSomethingWentWrong = 'common.something_went_wrong';
  static const commonConnectionTimeout = 'common.connection_timeout';
  static const commonRequestCancelled = 'common.request_cancelled';
}
