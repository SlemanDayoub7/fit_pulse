import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/localization/language_helpers.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';
import 'package:gym_app/features/nutrition/presentation/pages/nutrition_detail_page.dart';

class NutritionPlanWidget extends StatelessWidget {
  final NutritionPlan plan;

  const NutritionPlanWidget({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NutritionDetailPage(
              plan: plan,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 160.h,
        child: Card(
          elevation: 4,
          color: AppColors.white, // Different background color
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              _buildImage(),
              SizedBox(width: 12.w),
              Expanded(child: _buildTextContent(context)),
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(Icons.arrow_forward_ios,
                    size: 18.sp, color: AppColors.nutritionPrimary),
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
        topLeft: Radius.circular(14.r),
        bottomLeft: Radius.circular(14.r),
      ),
      child: plan.image != null && plan.image!.isNotEmpty
          ? Image.network(
              plan.image!,
              width: 110.w,
              height: 160.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image,
                  size: 80.h,
                  color: AppColors.nutritionPrimary),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: 110.w,
                  height: 160.h,
                  color: AppColors.gray,
                  child: Center(
                      child: CircularProgressIndicator(
                          color: AppColors.nutritionPrimary)),
                );
              },
            )
          : Container(
              width: 110.w,
              height: 160.h,
              color: AppColors.nutritionOffPrimary,
              child: Icon(Icons.image,
                  size: 50.h, color: AppColors.nutritionPrimary),
            ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizedText(en: plan.nameEn, ar: plan.nameAr),
            style: AppText.s16W600,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Text(
            localizedText(
                en: plan.target,
                ar: plan.target), // Assuming target is localized string or same
            style: AppText.s14w500.copyWith(color: AppColors.nutritionPrimary),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  size: 14.sp, color: AppColors.nutritionPrimary),
              SizedBox(width: 6.w),
              Text(
                '${plan.weeks} أسابيع',
                style: AppText.s12w400,
              ),
            ],
          ),
          SizedBox(height: 8.h),
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
