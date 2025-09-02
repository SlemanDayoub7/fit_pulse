import 'package:flutter/material.dart';
import 'package:gym_app/core/helpers/extensions.dart';
import 'package:gym_app/core/localization/language_helpers.dart';
import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/features/workouts/presentation/widgets/exercise_detail/exercise_info_sections.dart';

import 'package:gym_app/features/workouts/presentation/widgets/exercise_detail/exercise_utils.dart';
import 'package:gym_app/features/workouts/presentation/widgets/exercise_detail/exercise_video_player.dart';

import '../../../data/models/response_models/workout_plan.dart';

class ExerciseDetailPageBody extends StatelessWidget {
  final Exercise exercise;
  final String reps;
  final String sets;

  ExerciseDetailPageBody({
    super.key,
    required this.exercise,
    required this.reps,
    required this.sets,
  });

  @override
  Widget build(BuildContext context) {
    final name = localizedExerciseName(exercise);
    final description = localizedExerciseDescription(exercise);
    final howTo = localizedExerciseHowTo(exercise);
    final muscles = localizedExerciseMuscles(exercise);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          exercise.video.isNullOrEmpty()
              ? SizedBox()
              : ExerciseVideoPlayer(
                  videoUrl: exercise.video ?? '', title: name),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExerciseInfoCard(
                    title: localizedText(en: 'Description', ar: 'الوصف'),
                    child: Text(description, style: AppText.s14w400),
                  ),
                  SizedBox(height: 16.h),
                  ExerciseInfoCard(
                    title: localizedText(
                        en: 'Targeted Muscles', ar: 'العضلات المستهدفة'),
                    child: Wrap(
                      spacing: 8,
                      children: muscles
                          .map((m) => Chip(
                                backgroundColor: AppColors.offPrimary,
                                label: Text(m, style: AppText.s14w400),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ExerciseInfoCard(
                    title: localizedText(en: 'How to Play', ar: 'كيفية الأداء'),
                    child: Text(howTo, style: AppText.s14w400),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: ExerciseInfoCard(
                          title: localizedText(en: 'Time', ar: 'المدة'),
                          child: Row(
                            children: [
                              Icon(Icons.timer,
                                  color: AppColors.primary, size: 20.r),
                              SizedBox(width: 8.w),
                              Text(
                                '${exercise.time} ${getCurrentLanguage() == "ar" ? "ثواني" : "seconds"}',
                                style: AppText.s14w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ExerciseInfoCard(
                          title: localizedText(en: 'Sets', ar: 'المجموعات'),
                          child: Text(sets, style: AppText.s14w400),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ExerciseInfoCard(
                          title:
                              localizedText(en: 'Repetitions', ar: 'التكرارات'),
                          child: Text(reps, style: AppText.s14w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
