import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/gen/assets.gen.dart';

import '../../../../generated/codegen_loader.g.dart';

class MealDetailsPage extends StatelessWidget {
  const MealDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Top Image and Info
          Stack(
            children: [
              Assets.images.nutrition.lunch.image(
                height: 300.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 300.h,
                color: AppColors.black.withOpacity(0.4),
              ),
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: BackButton(color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Text(
                    "وجبة الغداء",
                    style: AppText.s22W600.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "وجبة الغداء",
                          style: AppText.s22W600
                              .copyWith(color: AppColors.nutritionPrimary),
                        ),
                        Spacer(),
                        _infoTag(
                            LocaleKeys.calorie.tr(),
                            "800",
                            Assets.svgs.calories
                                .svg(width: 20.w, height: 20.w)),
                        SizedBox(
                          width: 20.w,
                        ),
                        _infoTag(LocaleKeys.minute.tr(), "30",
                            Assets.svgs.time.svg(width: 20.w, height: 20.w)),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "أرز مع اللحمة وخضار السوتيه",
                      style: AppText.s18W600,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      overflow: TextOverflow.visible,
                      "تعتبر غنية بالبروتينات من اللحم، مما يساعد على بناء العضلات وتعزيز الصحة العامة. كما تحتوي الخضار المسلوقة على الفيتامينات والمعادن الهامة، في حين يوفر الأرز الكربوهيدرات التي تمنح الجسم الطاقة اللازمة للأنشطة اليومية",
                      style: AppText.s16W500,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _macroInfo(LocaleKeys.carbohydrates.tr(), "170",
                            Assets.svgs.carbs.svg(width: 30.w, height: 30.h)),
                        _macroInfo(
                            LocaleKeys.fat.tr(),
                            "40",
                            Assets.svgs.calories
                                .svg(width: 30.w, height: 30.h)),
                        _macroInfo(LocaleKeys.protein.tr(), "120",
                            Assets.svgs.protein.svg(width: 30.w, height: 30.h)),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          Theme(
                              data: Theme.of(context).copyWith(
                                tabBarTheme: TabBarTheme(
                                  labelStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold),
                                  unselectedLabelStyle:
                                      TextStyle(fontSize: 14.sp),
                                  labelColor: AppColors.nutritionPrimary,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor: AppColors.nutritionPrimary,
                                ),
                              ),
                              child: TabBar(
                                labelStyle: AppText.s16W500,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: AppColors.nutritionPrimary,
                                labelColor: AppColors.nutritionPrimary,
                                unselectedLabelColor: Colors.grey,
                                unselectedLabelStyle: AppText.s14w400,
                                tabs: [
                                  Tab(text: "المكونات"),
                                  Tab(text: "طريقة التحضير"),
                                ],
                              )),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 150.h,
                            child: TabBarView(
                              children: [
                                // Ingredients Tab
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _ingredientRow(
                                        "أرز", "100 ${LocaleKeys.grams.tr()}"),
                                    _ingredientRow(
                                        "لحمة", "150 ${LocaleKeys.grams.tr()}"),
                                    _ingredientRow("خضار", "كوب"),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("اطبخ الأرز", style: AppText.s16W500),
                                    Text(
                                        style: AppText.s16W500,
                                        "نضع في الطنجرة كأس ونصف من الماء المغلية وملعقة صغيرة ملح وملعقة صغيرة من زيت الزيتون ثم نضع 100غ من الرز ثم نتركه ربع ساعة على نار هادئة."),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTag(String text, String value, Widget icon) {
    return Container(
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1.5.w, color: AppColors.nutritionPrimary)),
      child: Row(
        children: [
          icon,
          SizedBox(width: 4.w),
          Text(value,
              style: AppText.s14w600.copyWith(color: AppColors.primary)),
          SizedBox(width: 4.w),
          Text(text,
              style:
                  AppText.s14w600.copyWith(color: AppColors.nutritionPrimary)),
        ],
      ),
    );
  }

  Widget _macroInfo(String label, String value, Widget icon) {
    return Column(
      children: [
        icon,
        SizedBox(height: 6.h),
        Text("$value", style: AppText.s14w600),
        Text(label, style: AppText.s12w400),
      ],
    );
  }

  Widget _ingredientRow(String name, String qty) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(qty, style: AppText.s12w400),
          Text(name, style: AppText.s14w400),
        ],
      ),
    );
  }
}
