import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_radius.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/custom_text_field.dart';
import 'package:gym_app/core/widgets/custom_top.dart';
import 'package:gym_app/features/nutrition/presentation/bloc/nutrition_plans_bloc.dart';
import 'package:gym_app/features/nutrition/presentation/bloc/nutrition_plans_event.dart';
import 'package:gym_app/features/nutrition/presentation/bloc/nutrition_plans_state.dart';
import 'package:gym_app/features/nutrition/presentation/widgets/nutrition_plan_widget.dart';

import 'package:gym_app/gen/assets.gen.dart';

import '../../../../generated/codegen_loader.g.dart';

class NutritionPlansPage extends StatefulWidget {
  @override
  _NutritionPlansPageState createState() => _NutritionPlansPageState();
}

class _NutritionPlansPageState extends State<NutritionPlansPage> {
  String selectedCategory = LocaleKeys.all.tr();

  // Static categories list
  final List<String> categories = [
    'الكل',
    'فقدان الوزن',
    'زيادة العضلات',
    'نباتي',
    'كيتو',
  ];

  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Trigger loading nutrition plans from BLoC
    context.read<NutritionPlansBloc>().add(LoadNutritionPlans());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: add AppBar or keep as full screen
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTop(
                icon: Assets.images.nutrition.nutrition
                    .image(height: 77.h, width: 83.w),
                title: LocaleKeys.nutrition_plans.tr(),
              ),
              SizedBox(height: 31.h),
              CustomTextField(
                controller: searchController,
                hintText: LocaleKeys.search_plans.tr(),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: 16.h),
              // Static categories ListView
              SizedBox(
                height: 40.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    final isSelected = category == selectedCategory;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 6.5.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.nutritionPrimary),
                          color: isSelected
                              ? AppColors.nutritionPrimary
                              : AppColors.white,
                          borderRadius: AppRadius.circularR12,
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: AppText.s14w400.copyWith(
                              color: !isSelected
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<NutritionPlansBloc, NutritionPlansState>(
                builder: (context, state) {
                  if (state is NutritionPlansLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is NutritionPlansLoaded) {
                    final filteredPlans = state.nutritionPlans.where((plan) {
                      final matchesCategory =
                          selectedCategory == LocaleKeys.all.tr() ||
                              plan.target == selectedCategory ||
                              plan.nameEn == selectedCategory ||
                              plan.nameAr == selectedCategory;

                      final matchesSearch = plan.nameEn
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                          plan.nameAr
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase());

                      return matchesCategory && matchesSearch;
                    }).toList();

                    if (filteredPlans.isEmpty) {
                      return Center(child: Text('لا توجد خطط مطابقة'));
                    }

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredPlans.length,
                      itemBuilder: (context, index) {
                        final plan = filteredPlans[index];

                        return NutritionPlanWidget(plan: plan);
                      },
                    );
                  } else if (state is NutritionPlansError) {
                    return Center(child: Text('خطأ: ${state.message}'));
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoTag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.nutritionPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: AppColors.nutritionPrimary),
          SizedBox(width: 6.w),
          Text(label,
              style:
                  AppText.s12w400.copyWith(color: AppColors.nutritionPrimary)),
        ],
      ),
    );
  }
}
