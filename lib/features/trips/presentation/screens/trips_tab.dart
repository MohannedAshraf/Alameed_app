import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/repositories/trips_repository.dart';
import '../widgets/trip_list_tile.dart';

class TripsTab extends StatelessWidget {
  const TripsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = sl<TripsRepository>();

    return ListenableBuilder(
      listenable: repository,
      builder: (context, _) {
        final trips = repository.getAllTrips();
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
