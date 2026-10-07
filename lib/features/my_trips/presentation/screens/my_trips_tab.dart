import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../trips/domain/repositories/trips_repository.dart';
import '../../../trips/presentation/widgets/trip_list_tile.dart';

class MyTripsTab extends StatelessWidget {
  const MyTripsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = sl<TripsRepository>();

    return ListenableBuilder(
      listenable: repository,
      builder: (context, _) {
        final trips = repository.getMyTrips();

        if (trips.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Text(
                LocaleKeys.homeNoBookedTrips.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyles.body,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          itemCount: trips.length,
          itemBuilder: (context, index) {
            final trip = trips[index];
            return TripListTile(
              trip: trip,
              isFavourite: repository.isFavourite(trip.id),
              onFavouriteToggle: () => repository.toggleFavourite(trip.id),
            );
          },
        );
      },
    );
  }
}
