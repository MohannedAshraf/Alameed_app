import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../trips/domain/repositories/trips_repository.dart';
import '../../../trips/presentation/widgets/trip_list_tile.dart';

class MyTripsTab extends StatefulWidget {
  const MyTripsTab({super.key});

  @override
  State<MyTripsTab> createState() => _MyTripsTabState();
}

class _MyTripsTabState extends State<MyTripsTab> {
  final _repository = sl<TripsRepository>();

  @override
  Widget build(BuildContext context) {
    final trips = _repository.getMyTrips();

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
          isFavourite: _repository.isFavourite(trip.id),
          onFavouriteToggle: () =>
              setState(() => _repository.toggleFavourite(trip.id)),
        );
      },
    );
  }
}
