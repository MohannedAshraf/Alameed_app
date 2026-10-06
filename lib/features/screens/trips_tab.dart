import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';

/// TEMPORARY placeholder — هنبنيها كـ feature كاملة بعدين.
class TripsTab extends StatelessWidget {
  const TripsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(LocaleKeys.homeComingSoon.tr(), style: AppTextStyles.body),
    );
  }
}
