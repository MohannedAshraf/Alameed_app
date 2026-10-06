import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

/// Carousel بيتحرك لوحده. الصور دلوقتي placeholder (اللوجو مكرر) لحد
/// م يبقى عندنا صور رحلات حقيقية — غيّر imagePaths لمسارات حقيقية
/// لما features/trips يبقى فيها بيانات.
class TripCarousel extends StatefulWidget {
  const TripCarousel({super.key, required this.imagePaths});

  final List<String> imagePaths;

  @override
  State<TripCarousel> createState() => _TripCarouselState();
}

class _TripCarouselState extends State<TripCarousel> {
  final _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || widget.imagePaths.length < 2) return;
      _currentPage = (_currentPage + 1) % widget.imagePaths.length;
      _pageController.animateToPage(
        _currentPage,
        duration: AppDurations.medium,
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            onPageChanged: (index) => _currentPage = index,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: Image.asset(
                  widget.imagePaths[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        AnimatedBuilder(
          animation: _pageController,
          builder: (context, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.imagePaths.length, (index) {
                final isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: AppDurations.fast,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: isActive ? 18.w : 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primary : AppColors.greyLight,
                    borderRadius: BorderRadius.circular(AppRadius.circular),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
