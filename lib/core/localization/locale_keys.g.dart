// This file mirrors assets/translations/en.json and ar.json.
//
// Regenerate anytime you add a key:
//   flutter pub run easy_localization:generate -f keys \
//     -S assets/translations -O lib/core/localization -o locale_keys.g.dart
//
// Usage in a widget: Text(LocaleKeys.authLoginButton.tr())

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
  static const commonInvalidEmail = 'common.invalid_email';
  static const commonInvalidPassword = 'common.invalid_password';
  static const commonInvalidPhone = 'common.invalid_phone';
  static const commonInvalidOtp = 'common.invalid_otp';
  static const commonRequiredField = 'common.required_field';
  static const commonPasswordMismatch = 'common.password_mismatch';
  static const commonEmailAlreadyInUse = 'common.email_already_in_use';
  static const commonWeakPassword = 'common.weak_password';
  static const commonUserNotFound = 'common.user_not_found';
  static const commonWrongPassword = 'common.wrong_password';
  static const commonTooManyRequests = 'common.too_many_requests';

  // auth.*
  static const authWelcomeBack = 'auth.welcome_back';
  static const authLoginSubtitle = 'auth.login_subtitle';
  static const authEmailTab = 'auth.email_tab';
  static const authPhoneTab = 'auth.phone_tab';
  static const authEmailHint = 'auth.email_hint';
  static const authPasswordHint = 'auth.password_hint';
  static const authConfirmPasswordHint = 'auth.confirm_password_hint';
  static const authNameHint = 'auth.name_hint';
  static const authPhoneHint = 'auth.phone_hint';
  static const authForgotPassword = 'auth.forgot_password';
  static const authLoginButton = 'auth.login_button';
  static const authSendCode = 'auth.send_code';
  static const authOrContinueWith = 'auth.or_continue_with';
  static const authContinueWithGoogle = 'auth.continue_with_google';
  static const authContinueWithApple = 'auth.continue_with_apple';
  static const authNoAccount = 'auth.no_account';
  static const authCreateAccount = 'auth.create_account';
  static const authRegisterTitle = 'auth.register_title';
  static const authRegisterSubtitle = 'auth.register_subtitle';
  static const authRegisterButton = 'auth.register_button';
  static const authAlreadyHaveAccount = 'auth.already_have_account';
  static const authLoginLink = 'auth.login_link';
  static const authOtpTitle = 'auth.otp_title';
  static const authOtpSubtitle = 'auth.otp_subtitle';
  static const authOtpHint = 'auth.otp_hint';
  static const authOtpResent = 'auth.otp_resent';
  static const authVerifyButton = 'auth.verify_button';
  static const authDidntReceiveCode = 'auth.didnt_receive_code';
  static const authResendCode = 'auth.resend_code';
  static const authForgotPasswordSubtitle = 'auth.forgot_password_subtitle';
  static const authResetOtpSubtitle = 'auth.reset_otp_subtitle';
  static const authNewPasswordTitle = 'auth.new_password_title';
  static const authNewPasswordSubtitle = 'auth.new_password_subtitle';
  static const authNewPasswordHint = 'auth.new_password_hint';
  static const authSavePasswordButton = 'auth.save_password_button';
  static const authPasswordChangedSuccess = 'auth.password_changed_success';

  // nav.*
  static const navHome = 'nav.home';
  static const navTrips = 'nav.trips';
  static const navMyTrips = 'nav.my_trips';
  static const navProfile = 'nav.profile';

  // home.*
  static const homeSearchHint = 'home.search_hint';
  static const homeFeaturedTrips = 'home.featured_trips';
  static const homeMenu = 'home.menu';
  static const homeSettings = 'home.settings';
  static const homeLogout = 'home.logout';
  static const homeComingSoon = 'home.coming_soon';
}
