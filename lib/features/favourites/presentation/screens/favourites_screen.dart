import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../trips/domain/repositories/trips_repository.dart';
import '../../../trips/presentation/widgets/trip_list_tile.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final _repository = sl<TripsRepository>();

  @override
  Widget build(BuildContext context) {
    final trips = _repository.getFavouriteTrips();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(LocaleKeys.homeFavourites.tr()),
      ),
      body: trips.isEmpty
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  LocaleKeys.homeNoFavourites.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return TripListTile(
                  trip: trip,
                  isFavourite: true,
                  onFavouriteToggle: () =>
                      setState(() => _repository.toggleFavourite(trip.id)),
                );
              },
            ),
    );
  }
}
