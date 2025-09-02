import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/features/weight_tracker/presentation/pages/add_weight_page.dart';
import 'package:gym_app/features/weight_tracker/presentation/pages/reminder_settings_page.dart';
import 'package:gym_app/features/weight_tracker/presentation/pages/weight_chart_page.dart';

class HomeWeight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text("تتبع الوزن"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.r),
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "📊 عرض المخطط",
              style: AppText.subtitle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WeightChartPage()),
              );
            },
          ),
          ListTile(
            title: Text(
              "➕ إدخال وزن جديد",
              style: AppText.subtitle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddWeightPage()),
              );
            },
          ),
          ListTile(
            title: Text(
              "⏰ إعداد التذكير",
              style: AppText.subtitle,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ReminderSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
