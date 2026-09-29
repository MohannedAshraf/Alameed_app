/// Static content for one onboarding page. All three pages currently
/// point at the same logo image — swap `image` for a real trip photo
/// per page once the content/design is ready.
class OnboardingPageData {
  const OnboardingPageData({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });

  final String image;
  final String titleKey;
  final String descriptionKey;
}
