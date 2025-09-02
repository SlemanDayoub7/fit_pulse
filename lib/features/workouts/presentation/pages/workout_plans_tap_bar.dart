import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/features/workouts/presentation/pages/monthly_workout_plans_page.dart';
import 'package:gym_app/features/workouts/presentation/pages/workout_plans_page.dart';
import 'package:gym_app/gen/assets.gen.dart';

class WorkoutPlansTapBar extends StatefulWidget {
  @override
  _WorkoutPlansTapBarState createState() => _WorkoutPlansTapBarState();
}

class _WorkoutPlansTapBarState extends State<WorkoutPlansTapBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //     color: AppColors.primary.withOpacity(0.5),
          //     width: 1.sw,
          //     height: 1.sh),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  spacing: 10.w,
                  children: [
                    Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.primary),
                        child: Center(
                            child: Assets.svgs.dumbbells.svg(
                                width: 18.w,
                                height: 18.h,
                                color: AppColors.white))),
                    Text(
                      'Workout Plans',
                      style: AppText.heading.copyWith(),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    textColor: _currentIndex == 0
                        ? AppColors.white
                        : AppColors.primary,
                    backgroundColor: _currentIndex != 0
                        ? AppColors.white
                        : AppColors.primary,
                    minimumWidth: 0.45.sw,
                    minimumHeight: 40.h,
                    title: 'Monthly',
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                  AppButton(
                    minimumHeight: 40.h,
                    textColor: _currentIndex != 0
                        ? AppColors.white
                        : AppColors.primary,
                    backgroundColor: _currentIndex == 0
                        ? AppColors.white
                        : AppColors.primary,
                    minimumWidth: 0.45.sw,
                    title: 'Session',
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                  child: _currentIndex == 0
                      ? MonthlyWorkoutPlansPage()
                      : WorkoutPlansPage())
            ],
          ),
        ],
      ),
    );
  }
}
