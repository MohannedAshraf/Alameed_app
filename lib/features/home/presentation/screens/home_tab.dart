import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/trip_card.dart';
import '../widgets/trip_carousel.dart';

/// تاب "الرئيسية". كل البيانات هنا placeholder (مفيش ربط بباك اند
/// حقيقي لسه) — هتتستبدل لما features/trips تتبني بالكامل.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  static const _featuredTrips = [
    TripCardData(
      title: 'الأقصر وأسوان',
      location: 'الأقصر، مصر',
      price: 'يبدأ من 2500 جنيه',
      imagePath: AppImages.logo,
    ),
    TripCardData(
      title: 'شرم الشيخ',
      location: 'جنوب سيناء، مصر',
      price: 'يبدأ من 3200 جنيه',
      imagePath: AppImages.logo,
    ),
    TripCardData(
      title: 'سيوة',
      location: 'مطروح، مصر',
      price: 'يبدأ من 1800 جنيه',
      imagePath: AppImages.logo,
    ),
    TripCardData(
      title: 'الجونة',
      location: 'البحر الأحمر، مصر',
      price: 'يبدأ من 2900 جنيه',
      imagePath: AppImages.logo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: AppSpacing.md),

          // ---- Search bar ----
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: TextField(
              readOnly: true, // TODO: فعّلها لما تتبنى صفحة البحث
              onTap: () {},
              decoration: InputDecoration(
                hintText: LocaleKeys.homeSearchHint.tr(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(height: AppSpacing.lg),

          // ---- Carousel ----
          const TripCarousel(
            imagePaths: [AppImages.logo, AppImages.logo, AppImages.logo],
          ),
          SizedBox(height: AppSpacing.lg),

          // ---- Featured trips ----
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              LocaleKeys.homeFeaturedTrips.tr(),
              style: AppTextStyles.title,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _featuredTrips.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) =>
                  TripCard(data: _featuredTrips[index]),
            ),
          ),
        ],
      ),
    );
  }
}
