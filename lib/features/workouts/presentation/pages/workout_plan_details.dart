import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/helpers/extensions.dart';
import 'package:gym_app/core/localization/language_helpers.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/core/widgets/generic_cached_image.dart';
import 'package:gym_app/features/training/domain/models/exercise_training.dart';
import 'package:gym_app/features/training/presentation/bloc/training_bloc.dart';
import 'package:gym_app/features/training/presentation/pages/training_page.dart';
import 'package:gym_app/features/workout_session/domain/entities/exercise.dart';
import 'package:gym_app/features/workout_session/presentation/pages/sc.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';
import 'package:gym_app/features/workouts/domain/entities/day_of_week.dart';
import 'package:gym_app/features/workouts/presentation/pages/exercise_detail_page.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';

class WorkoutPlanDetailPage extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  const WorkoutPlanDetailPage({super.key, required this.workoutPlan});

  Map<int, Map<DayOfWeek, List<WorkoutPlanDetail>>> classifyByWeekAndDayEnum(
      List<WorkoutPlanDetail> details) {
    final Map<int, Map<DayOfWeek, List<WorkoutPlanDetail>>> result = {};
    for (var detail in details) {
      final week = detail.week ?? 0;
      final dayEnum = DayOfWeek.fromNumber(detail.day ?? 0);
      if (dayEnum == null) continue;
      result.putIfAbsent(week, () => {});
      result[week]!.putIfAbsent(dayEnum, () => []);
      result[week]![dayEnum]!.add(detail);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final classified = classifyByWeekAndDayEnum(workoutPlan.details ?? []);
    final classifiedIntKeys = classified.map((week, dayMap) => MapEntry(
          week,
          dayMap.map((dayEnum, details) => MapEntry(dayEnum.number, details)),
        ));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGlassCard(_buildDescriptionSection(context)),
                    SizedBox(height: 16.h),
                    _buildGlassCard(_buildOverviewSection()),
                    SizedBox(height: 16.h),
                    _buildGlassCard(_buildAdviceSection()),
                    SizedBox(height: 16.h),
                    if (!workoutPlan.details.isNullOrEmpty())
                      _buildGlassCard(
                          WeekSchedule(classifiedDetails: classifiedIntKeys)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTag(context),
        SizedBox(height: 8.h),
        Text(
          localizedText(
              en: workoutPlan.descriptionEn, ar: workoutPlan.descriptionAr),
          style: AppText.s13w400,
        ),
      ],
    );
  }

  Widget _buildGlassCard(Widget child) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        GenericCachedImage(
          imageUrl: workoutPlan.image ?? '',
          height: 260.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          height: 260.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16.h,
          left: 16.w,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 20.h,
          left: 16.w,
          right: 16.w,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Text(
              localizedText(en: workoutPlan.nameEn, ar: workoutPlan.nameAr),
              style: AppText.s20W600.copyWith(
                color: Colors.white,
                shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        localizedText(
          en: workoutPlan.sportEn,
          ar: workoutPlan.sportAr,
        ),
        style: TextStyle(
          color: Colors.orange.shade800,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.exercise_overview.tr(), style: AppText.s15w600),
        SizedBox(height: 10.h),
        _buildOverviewRow(
            '${LocaleKeys.days.tr()}:', workoutPlan.days.toString()),
        _buildOverviewRow(
            '${LocaleKeys.weeks.tr()}:', workoutPlan.weeks.toString()),
        _buildOverviewRow(
            '${LocaleKeys.goal.tr()}:',
            localizedText(
                en: workoutPlan.planGoalEn, ar: workoutPlan.planGoalAr)),
      ],
    );
  }

  Widget _buildAdviceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.important_tips.tr(), style: AppText.s14w600),
        SizedBox(height: 6.h),
        Text(
          localizedText(en: workoutPlan.adviceEn, ar: workoutPlan.adviceAr),
          style: AppText.s13w400,
        ),
      ],
    );
  }

  Widget _buildOverviewRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Text(label, style: AppText.s13w600),
          SizedBox(width: 6.w),
          Expanded(child: Text(value, style: AppText.s13w400)),
        ],
      ),
    );
  }
}

class WeekSchedule extends StatefulWidget {
  final Map<int, Map<int, List<WorkoutPlanDetail>>> classifiedDetails;

  const WeekSchedule({Key? key, required this.classifiedDetails})
      : super(key: key);

  @override
  State<WeekSchedule> createState() => _WeekScheduleState();
}

class _WeekScheduleState extends State<WeekSchedule> {
  late int selectedWeek;
  int? selectedDay;

  static Map<int, String> dayNames = {
    1: LocaleKeys.saturday.tr(),
    2: LocaleKeys.sunday.tr(),
    3: LocaleKeys.monday.tr(),
    4: LocaleKeys.tuesday.tr(),
    5: LocaleKeys.wednesday.tr(),
    6: LocaleKeys.thursday.tr(),
    7: LocaleKeys.friday.tr(),
  };

  @override
  void initState() {
    super.initState();
    selectedWeek = widget.classifiedDetails.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    final days = widget.classifiedDetails[selectedWeek]?.keys.toList() ?? [];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(LocaleKeys.training_days.tr(), style: AppText.s15w600),
      SizedBox(height: 12.h),

      /// Week Selector
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.classifiedDetails.keys.map((week) {
            final isSelected = week == selectedWeek;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: ChoiceChip(
                label: Text('${LocaleKeys.week.tr()} $week'),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    selectedWeek = week;
                    selectedDay = null;
                  });
                },
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ),
      SizedBox(height: 20.h),

      /// Day Selector
      Wrap(
        spacing: 10.w,
        runSpacing: 8.h,
        children: days.map((day) {
          final isSelected = day == selectedDay;
          return ChoiceChip(
            label: Text(dayNames[day] ?? '${LocaleKeys.day.tr()} $day'),
            selected: isSelected,
            onSelected: (_) {
              setState(() => selectedDay = day);
            },
            selectedColor: AppColors.primary.withOpacity(0.9),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          );
        }).toList(),
      ),
      SizedBox(height: 20.h),

      /// Exercise Cards
      if (selectedDay != null) ...[
        AppButton(
          title: LocaleKeys.start_exercise.tr(),
          onPressed: () {
            final selectedDetails =
                widget.classifiedDetails[selectedWeek]![selectedDay]!;

            final List<ExerciseEntity> exercisesToTrain =
                selectedDetails.map((detail) {
              final ex = detail.exercise!;
              return ExerciseEntity(
                name: localizedText(en: ex.nameEn, ar: ex.nameAr),
                description:
                    localizedText(en: ex.descriptionEn, ar: ex.descriptionAr),
                videoUrl: ex.video,
                sets: detail.sets ?? 0,
                reps:
                    detail.repsAr!.split(',').map((e) => int.parse(e)).toList(),
                id: '',
                coverImage: '', // or repsAr if Arabic needed
              );
            }).toList();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WorkoutSessionScreen(
                  exercises: exercisesToTrain,
                ),
              ),
            );
          },
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              widget.classifiedDetails[selectedWeek]![selectedDay]!.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final detail =
                widget.classifiedDetails[selectedWeek]![selectedDay]![index];
            final ex = detail.exercise;

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseDetailPage(
                        exercise: ex!,
                        reps:
                            localizedText(en: detail.repsEn, ar: detail.repsAr),
                        sets: detail.sets.toString(),
                      ),
                    ),
                  );
                },
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: ex?.image != null
                      ? Image.network(
                          'https://ahmadshamma.pythonanywhere.com/${ex!.image!}',
                          width: 50.w,
                          height: 50.w,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.fitness_center,
                          size: 40.r, color: AppColors.primary),
                ),
                title: Text(
                  localizedText(en: ex?.nameEn, ar: ex?.nameAr),
                  style: AppText.s15w600,
                ),
                subtitle: Text(
                  'ٌ${LocaleKeys.sets.tr()}: ${detail.sets ?? '-'} | ${LocaleKeys.repetitions.tr()}: ${detail.repsAr ?? '-'}',
                  style: AppText.s13w400,
                ),
              ),
            );
          },
        ),
      ],
    ]);
  }
}
