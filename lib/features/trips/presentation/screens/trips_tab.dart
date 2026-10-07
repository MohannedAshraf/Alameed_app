import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/repositories/trips_repository.dart';
import '../widgets/trip_list_tile.dart';

class TripsTab extends StatefulWidget {
  const TripsTab({super.key});

  @override
  State<TripsTab> createState() => _TripsTabState();
}

class _TripsTabState extends State<TripsTab> {
  final _repository = sl<TripsRepository>();

  @override
  Widget build(BuildContext context) {
    final trips = _repository.getAllTrips();

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
