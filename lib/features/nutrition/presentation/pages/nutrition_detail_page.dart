import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/custom_top.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';
import 'package:gym_app/features/nutrition/presentation/widgets/daily_goal_widget.dart';
import 'package:gym_app/features/nutrition/presentation/widgets/meal_card.dart';
import 'package:gym_app/features/nutrition/presentation/widgets/week_schedule.dart';
import 'package:gym_app/gen/assets.gen.dart';

import '../../../../generated/codegen_loader.g.dart' show LocaleKeys;

class NutritionDetailPage extends StatelessWidget {
  final NutritionPlan plan;

  const NutritionDetailPage({Key? key, required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate total calories from meals if needed
    final totalCalories =
        plan.meals.fold<int>(0, (sum, meal) => sum + meal.calories);

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 540.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 30.w),
                          child: CustomTop(
                            title: plan.nameEn,
                            icon: Assets.images.nutrition.nutritionPlanDetails
                                .image(height: 77.h, width: 83.w),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(plan.descriptionEn, style: AppText.s14w400),
                        Divider(
                            height: 24.h, color: AppColors.nutritionPrimary),
                        Text(LocaleKeys.plan_overview.tr(),
                            style: AppText.s16W600),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Text(
                                '${LocaleKeys.duration.tr()}: ${plan.weeks} ${LocaleKeys.weeks.tr()}',
                                style: AppText.s12w400),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Text(
                                '${LocaleKeys.goal_nutrition.tr()}: ${plan.target}',
                                style: AppText.s12w400),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Text('${LocaleKeys.calories.tr()}: $totalCalories',
                                style: AppText.s12w400),
                          ],
                        ),
                        Divider(
                            height: 24.h, color: AppColors.nutritionPrimary),
                        Text(LocaleKeys.plan_days.tr(), style: AppText.s16W600),
                        SizedBox(height: 10.h),
                        WeekSchedule(
                          plan: plan,
                        ),
                        Divider(
                            height: 24.h, color: AppColors.nutritionPrimary),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                DailyGoalWidget(
                  meals: plan.meals,
                  day: 1,
                ),
                SizedBox(height: 20.h),
                Text(LocaleKeys.meals.tr(), style: AppText.s16W600),
                SizedBox(height: 12.h),
                ...plan.meals.map((meal) {
                  return MealCard(
                    title: meal.mealNameEn,
                    calories: meal.calories.toString(),
                    description: meal.foodItems.isNotEmpty
                        ? meal.foodItems.map((f) => f.nameEn).join(', ')
                        : LocaleKeys.no_food_items.tr(),
                    imagePath:
                        '', // You can add an image URL or asset path if available
                  );
                }).toList(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
