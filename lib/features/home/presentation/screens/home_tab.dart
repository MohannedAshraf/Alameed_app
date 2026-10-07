import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../trips/domain/repositories/trips_repository.dart';
import '../widgets/trip_card.dart';
import '../widgets/trip_carousel.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = sl<TripsRepository>();

    return ListenableBuilder(
      listenable: repository,
      builder: (context, _) {
        final trips = repository.getAllTrips();
        final featuredTrips = trips.take(4).toList();
        final carouselImages = trips.take(3).map((t) => t.imagePath).toList();

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: AppSpacing.md),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: TextField(
                  readOnly: true,
                  onTap: () {},
                  decoration: InputDecoration(
                    hintText: LocaleKeys.homeSearchHint.tr(),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              TripCarousel(imagePaths: carouselImages),
              SizedBox(height: AppSpacing.lg),
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
                  itemCount: featuredTrips.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) =>
                      TripCard(trip: featuredTrips[index]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
