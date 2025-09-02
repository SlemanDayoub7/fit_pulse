import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/localization/language_helpers.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_radius.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/custom_text_field.dart';
import 'package:gym_app/core/widgets/custom_top.dart';
import 'package:gym_app/core/widgets/generic_refresh_indicator.dart';
import 'package:gym_app/core/widgets/shimmers/categories_shimmer.dart';
import 'package:gym_app/core/widgets/shimmers/list_shimmer.dart';
import 'package:gym_app/features/workout_session/presentation/pages/sc.dart';
import 'package:gym_app/features/workouts/presentation/bloc/sports_bloc/sports_bloc.dart';
import 'package:gym_app/features/workouts/presentation/bloc/sports_bloc/sports_event.dart';
import 'package:gym_app/features/workouts/presentation/bloc/sports_bloc/sports_state.dart';
import 'package:gym_app/features/workouts/presentation/bloc/workout_plans_bloc.dart';
import 'package:gym_app/features/workouts/presentation/bloc/workout_plans_event.dart';
import 'package:gym_app/features/workouts/presentation/bloc/workout_plans_state.dart';
import 'package:gym_app/features/workouts/presentation/widgets/workout_plan/workout_plan_widget%20.dart';
import 'package:gym_app/gen/assets.gen.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';

import '../../../workout_session/presentation/pages/workout_session_page.dart';

class WorkoutPlansPage extends StatefulWidget {
  @override
  _WorkoutPlansPageState createState() => _WorkoutPlansPageState();
}

class _WorkoutPlansPageState extends State<WorkoutPlansPage>
    with SingleTickerProviderStateMixin {
  String selectedCategory = LocaleKeys.all.tr();
  List<String> categories = [];
  String searchQuery = '';
  TextEditingController searchController = TextEditingController();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    context.read<WorkoutPlansBloc>().add(LoadWorkoutPlans());
    context.read<SportsBloc>().add(LoadSports());

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericRefreshIndicator(onRefresh: () async {
      context.read<WorkoutPlansBloc>().add(LoadWorkoutPlans());
      context.read<SportsBloc>().add(LoadSports());

      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      );
    }, builder: (context) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(12.r),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => WorkoutSessionScreen(),
              //         ),
              //       );
              //     },
              //     child: Text('data')),
              CustomTop(
                icon: Assets.images.workout.workoutPlans.image(
                  height: 77.h,
                  width: 83.w,
                ),
                title: LocaleKeys.exercise_plans.tr(),
              ),
              SizedBox(height: 31.h),
              Container(
                width: double.maxFinite,
                child: CustomTextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  controller: searchController,
                  hintText: LocaleKeys.search_plans.tr(),
                ),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<SportsBloc, SportState>(
                builder: (context, state) {
                  if (state is SportsLoaded) {
                    categories = [
                      LocaleKeys.all.tr(),
                      ...state.sports
                          .map((e) =>
                              localizedText(ar: e.nameAr, en: e.nameEn ?? ''))
                          .toList()
                    ];
                  }
                  if (state is SportLoading) {
                    return CategoriesShimmer();
                  }
                  return SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 10.w),
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
                              border: Border.all(color: AppColors.primary),
                              color: isSelected
                                  ? AppColors.primary
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
                  );
                },
              ),
              SizedBox(height: 16.h),
              BlocBuilder<WorkoutPlansBloc, WorkoutPlanState>(
                builder: (context, state) {
                  if (state is WorkoutPlanLoading) {
                    return ListShimmer();
                  } else if (state is WorkoutPlansLoaded) {
                    final plans = state.workoutPlans.where((plan) {
                      final matchesCategory = selectedCategory ==
                              LocaleKeys.all.tr() ||
                          localizedText(en: plan.sportEn, ar: plan.sportAr) ==
                              selectedCategory;

                      final nameMatch =
                          localizedText(en: plan.nameEn, ar: plan.nameAr)
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase());

                      return matchesCategory && nameMatch;
                    }).toList();

                    _animationController.forward();

                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: plans.length,
                      itemBuilder: (_, index) {
                        final plan = plans[index];
                        final animation = Tween<Offset>(
                          begin: Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            (index / plans.length),
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ));
                        final fadeAnimation = Tween<double>(
                          begin: 0,
                          end: 1,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            (index / plans.length),
                            1.0,
                            curve: Curves.easeIn,
                          ),
                        ));

                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: SlideTransition(
                            position: animation,
                            child: WorkoutPlanWidget(plan: plan),
                          ),
                        );
                      },
                    );
                  } else if (state is WorkoutPlanError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
