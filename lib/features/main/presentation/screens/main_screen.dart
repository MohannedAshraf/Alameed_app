import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../home/presentation/screens/home_tab.dart';
import '../../../my_trips/presentation/screens/my_trips_tab.dart';
import '../../../profile/presentation/screens/profile_tab.dart';
import '../../../trips/presentation/screens/trips_tab.dart';
import '../widgets/app_drawer.dart';

/// الصفحة اللي المستخدم بيوصلها بعد تسجيل الدخول/الحساب بنجاح.
/// AppBar + Drawer مؤقت + Bottom Nav بـ 4 تابات.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const _tabs = [HomeTab(), TripsTab(), MyTripsTab(), ProfileTab()];

  static const _titles = [
    LocaleKeys.navHome,
    LocaleKeys.navTrips,
    LocaleKeys.navMyTrips,
    LocaleKeys.navProfile,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        title: Text(_titles[_currentIndex].tr()),
        // RTL: leading بيظهر على اليمين، actions بتظهر على الشمال.
        leading: IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {}, // TODO: صفحة الإشعارات
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: LocaleKeys.navHome.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.explore_outlined),
            activeIcon: const Icon(Icons.explore),
            label: LocaleKeys.navTrips.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.card_travel_outlined),
            activeIcon: const Icon(Icons.card_travel),
            label: LocaleKeys.navMyTrips.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: LocaleKeys.navProfile.tr(),
          ),
        ],
      ),
    );
  }
}
