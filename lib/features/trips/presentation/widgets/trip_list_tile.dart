// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/trip_entity.dart';
import '../screens/trip_details_screen.dart';

class TripListTile extends StatelessWidget {
  const TripListTile({
    super.key,
    required this.trip,
    required this.isFavourite,
    required this.onFavouriteToggle,
  });

  final TripEntity trip;
  final bool isFavourite;
  final VoidCallback onFavouriteToggle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TripDetailsScreen(tripId: trip.id)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.divider),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 110.w,
              height: 100.h,
              child: Image.asset(trip.imagePath, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.semiBold(fontSize: 14),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Text(
                            trip.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 2.w),
                        Text(trip.duration, style: AppTextStyles.bodySmall),
                      ],
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      trip.price,
                      style: AppTextStyles.semiBold(
                        fontSize: 13,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: GestureDetector(
                onTap: onFavouriteToggle,
                child: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  size: 26.sp,
                  color: isFavourite
                      ? AppColors.error
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
