import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/repositories/trips_repository.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key, required this.tripId});

  final String tripId;

  @override
  Widget build(BuildContext context) {
    final repository = sl<TripsRepository>();

    return ListenableBuilder(
      listenable: repository,
      builder: (context, _) {
        final trip = repository.getTripById(tripId);
        final isFavourite = repository.isFavourite(tripId);
        final isBooked = repository.isBooked(tripId);

        return Scaffold(
          backgroundColor: AppColors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.textPrimary,
                expandedHeight: 220.h,
                pinned: true,
                actions: [
                  IconButton(
                    icon: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite
                          ? AppColors.error
                          : AppColors.textPrimary,
                    ),
                    onPressed: () => repository.toggleFavourite(tripId),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(trip.imagePath, fit: BoxFit.cover),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(AppSpacing.lg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(trip.title, style: AppTextStyles.heading2),
                    SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(trip.location, style: AppTextStyles.body),
                      ],
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.access_time,
                          label: trip.duration,
                        ),
                        SizedBox(width: AppSpacing.sm),
                        _InfoChip(
                          icon: Icons.star,
                          label: trip.rating.toString(),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      LocaleKeys.homeTripDescription.tr(),
                      style: AppTextStyles.title,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      trip.description,
                      style: AppTextStyles.regular(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      LocaleKeys.homeTripIncluded.tr(),
                      style: AppTextStyles.title,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    ...trip.included.map(
                      (item) => _BulletRow(text: item, isPositive: true),
                    ),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      LocaleKeys.homeTripNotIncluded.tr(),
                      style: AppTextStyles.title,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    ...trip.notIncluded.map(
                      (item) => _BulletRow(text: item, isPositive: false),
                    ),
                    SizedBox(height: 100.h),
                  ]),
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: ElevatedButton(
                onPressed: isBooked
                    ? null
                    : () {
                        repository.bookTrip(tripId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(LocaleKeys.homeTripBooked.tr()),
                          ),
                        );
                      },
                child: Text(
                  isBooked
                      ? LocaleKeys.homeAlreadyBooked.tr()
                      : LocaleKeys.homeBookNow.tr(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColors.textSecondary),
          SizedBox(width: 4.w),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.text, required this.isPositive});

  final String text;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isPositive ? Icons.check_circle_outline : Icons.cancel_outlined,
            size: 16.sp,
            color: isPositive ? AppColors.success : AppColors.textHint,
          ),
          SizedBox(width: 6.w),
          Expanded(child: Text(text, style: AppTextStyles.body)),
        ],
      ),
    );
  }
}
