import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_styles.dart';

/// بيانات وهمية مؤقتة — هتتستبدل بموديل حقيقي جاي من الباك اند لما
/// features/trips تتبني بالكامل.
class TripCardData {
  const TripCardData({
    required this.title,
    required this.location,
    required this.price,
    required this.imagePath,
  });

  final String title;
  final String location;
  final String price;
  final String imagePath;
}

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.data});

  final TripCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.asset(data.imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.semiBold(fontSize: 14),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        data.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  data.price,
                  style: AppTextStyles.semiBold(
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
