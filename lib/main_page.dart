import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/shared_pref_keys.dart';
import 'package:gym_app/core/helpers/shared_pref_helper.dart';
import 'package:gym_app/core/networking/dio_factory.dart';
import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/screens.dart';

import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/core/widgets/app_scaffold.dart';
import 'package:gym_app/features/auth/presentation/pages/set_profile_info_page.dart';
import 'package:gym_app/features/nutrition/presentation/pages/nutrition_plans_page.dart';
import 'package:gym_app/features/workouts/presentation/pages/workout_plans_page.dart';
import 'package:gym_app/gen/assets.gen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WorkoutPlansPage(),
    NutritionPlansPage(),
    SetProfileInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            children: [
              AppButton(
                title: 'تسجيل الخروج',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => LogoutDialog(
                      onConfirm: () async {
                        await logout();
                      },
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: (_currentIndex == 0
            ? AppColors.primary
            : _currentIndex == 1
                ? AppColors.nutritionPrimary
                : AppColors.primary),
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white,
        selectedLabelStyle: AppText.s16W500,
        unselectedLabelStyle: AppText.s14w500,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Assets.svgs.barbell.svg(),
            label: 'التمارين',
          ),
          BottomNavigationBarItem(
            icon: Assets.svgs.nutrition.svg(),
            label: 'التغذية',
          ),
          BottomNavigationBarItem(
            icon: Assets.svgs.profile.svg(),
            label: 'الملف الشخصي',
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    await SharedPrefHelper.clearAllData();
    await SharedPrefHelper.clearAllSecuredData();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthSelectionPage(),
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const LogoutDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.exit_to_app,
              size: 48.sp,
              color: Colors.redAccent,
            ),
            SizedBox(height: 12.h),
            Text('Logout', style: AppText.s20W500),
            SizedBox(height: 8.h),
            Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: AppText.s14w400.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 20.h),
            Row(
              spacing: 20.w,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: onCancel,
                    backgroundColor: AppColors.white,
                    child: Text('Cancel', style: AppText.s16W500),
                  ),
                ),
                Expanded(
                  child: AppButton(
                    onPressed: onConfirm,
                    child: Text('Logout', style: AppText.s16W500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
