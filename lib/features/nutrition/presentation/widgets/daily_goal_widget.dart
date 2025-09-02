import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:collection/collection.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';

class DailyGoalWidget extends StatelessWidget {
  final List<Meal> meals;
  final int day;
  const DailyGoalWidget({super.key, required this.meals, required this.day});

  @override
  Widget build(BuildContext context) {
    final dailyTotals = calculateDailyTotals(meals);
    print(dailyTotals);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الهدف اليومي",
          style: AppText.s16W600,
        ),
        SizedBox(height: 20.h),
        _buildProgressRow(
            "كربوهيدرات",
            (dailyTotals[day]!['calories'] ?? 0).toInt(),
            100,
            AppColors.nutritionPrimary),
        SizedBox(height: 10.h),
        _buildProgressRow("دهون", (dailyTotals[day]!['carbs'] ?? 0).toInt(), 40,
            AppColors.orange),
        SizedBox(height: 10.h),
        _buildProgressRow("بروتين", (dailyTotals[day]!['protein'] ?? 0).toInt(),
            190, AppColors.red),
      ],
    );
  }

  Widget _buildProgressRow(String label, int total, int current, Color color) {
    double percent = current / total;
    percent = percent.clamp(0.0, 1.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 65.w,
          child: Text(
            label,
            style: AppText.s14w400,
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 211.w,
          child: Stack(
            children: [
              Container(
                width: 211.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: AppColors.nutritionOffPrimary,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              FractionallySizedBox(
                alignment: Alignment.centerRight,
                widthFactor: percent,
                child: Container(
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          "$total ج",
          style: AppText.s14w600,
        ),
      ],
    );
  }
}

// Function to calculate daily totals of macros and calories
Map<int, Map<String, double>> calculateDailyTotals(List<Meal> meals) {
  // Group meals by day
  final groupedByDay = groupBy(meals, (Meal meal) => meal.day);

  // Map day -> { 'calories': x, 'carbs': y, 'protein': z }
  final Map<int, Map<String, double>> dailyTotals = {};

  groupedByDay.forEach((day, mealsOfDay) {
    double totalCalories = 0;
    double totalCarbs = 0;
    double totalProtein = 0;

    for (var meal in mealsOfDay) {
      totalCalories += meal.calories.toDouble();
      totalCarbs += meal.carbs;
      totalProtein += meal.protein;
    }

    dailyTotals[day] = {
      'calories': totalCalories,
      'carbs': totalCarbs,
      'protein': totalProtein,
    };
  });

  return dailyTotals;
}
