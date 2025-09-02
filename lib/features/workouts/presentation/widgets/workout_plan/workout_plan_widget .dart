import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/localization/language_helpers.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/generic_cached_image.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';
import 'package:gym_app/features/workouts/presentation/pages/workout_plan_details.dart';

class WorkoutPlanWidget extends StatelessWidget {
  final WorkoutPlan plan;

  const WorkoutPlanWidget({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkoutPlanDetailPage(workoutPlan: plan),
          ),
        );
      },
      child: SizedBox(
        height: 160.h,
        child: Card(
          elevation: 3,
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    bottomLeft: Radius.circular(12.r),
                  ),
                  child: GenericCachedImage(
                      width: 100.w,
                      height: 160.h,
                      fit: BoxFit.cover,
                      imageUrl: plan.image ?? '')),
              SizedBox(width: 10.w),
              Expanded(child: _buildTextContent(context)),
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Icon(Icons.arrow_forward_ios, size: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.r),
        bottomLeft: Radius.circular(12.r),
      ),
      child: plan.image != null
          ? Image.network(
              'https://ahmadshamma.pythonanywhere.com/${plan.image!}',
              width: 100.w,
              height: 160.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image, size: 80.h),
            )
          : Container(
              width: 100.w,
              height: 160.h,
              color: AppColors.gray,
              child: Icon(Icons.image, size: 50.h, color: Colors.white),
            ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizedText(en: plan.nameEn, ar: plan.nameAr),
            style: AppText.s16W500,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            localizedText(en: plan.planGoalEn, ar: plan.planGoalAr),
            style: AppText.s14w400.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 14.sp, color: AppColors.secondary),
              SizedBox(width: 4.w),
              Text(
                '${plan.weeks ?? 0} أسبوع / ${plan.days ?? 0} يوم',
                style: AppText.s12w400.copyWith(color: AppColors.darkGray),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Text(
              localizedText(en: plan.descriptionEn, ar: plan.descriptionAr),
              style: AppText.s12w400,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
