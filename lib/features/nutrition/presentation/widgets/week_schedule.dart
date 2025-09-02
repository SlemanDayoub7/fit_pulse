import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';

class WeekSchedule extends StatefulWidget {
  final NutritionPlan plan;
  final void Function(int selectedDay)? onDaySelected;

  WeekSchedule({super.key, required this.plan, this.onDaySelected});

  @override
  State<WeekSchedule> createState() => _WeekScheduleState();
}

class _WeekScheduleState extends State<WeekSchedule> {
  int? selectedDay;
  List<int>? uniqueDays;
  Map<int, String>? dayNamesMap;

  @override
  void initState() {
    super.initState();

    uniqueDays = widget.plan.meals.map((meal) => meal.day).toSet().toList()
      ..sort();

    dayNamesMap = {
      1: 'سبت',
      2: 'أحد',
      3: 'اثنين',
      4: 'ثلاثاء',
      5: 'أربعاء',
      6: 'خميس',
      7: 'جمعة',
    };

    selectedDay =
        uniqueDays != null && uniqueDays!.isNotEmpty ? uniqueDays!.first : 1;
    print(uniqueDays);
  }

  @override
  Widget build(BuildContext context) {
    // Provide fallback empty list/map if null (should not be null after initState)
    final days = uniqueDays ?? [];
    final names = dayNamesMap ?? {};

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.nutritionOffPrimary,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'جدول الأسبوع',
            style: AppText.s14w500,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 25.r,
                color: AppColors.nutritionPrimary,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 25.r,
                color: AppColors.nutritionPrimary,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: days.map((day) {
              final isSelected = day == selectedDay;
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedDay = day;
                  });
                  if (widget.onDaySelected != null) {
                    widget.onDaySelected!(day);
                  }
                },
                child: Container(
                  width: 44.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.nutritionPrimary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.nutritionPrimary),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle_sharp,
                        color: isSelected ? Colors.white : AppColors.gray,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        names[day] ?? 'يوم $day',
                        style: AppText.s12w400.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      Text(
                        day.toString(),
                        style: AppText.s12w600.copyWith(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
