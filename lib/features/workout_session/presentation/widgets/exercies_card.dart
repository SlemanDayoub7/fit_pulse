import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/features/private_workout/data/models/exercise.dart';
import 'package:gym_app/features/workout_session/domain/entities/exercise.dart';
import 'package:gym_app/features/workout_session/presentation/widgets/set_pill.dart';
import 'package:gym_app/features/workouts/presentation/widgets/exercise_detail/exercise_video_player.dart';

import '../../../../generated/codegen_loader.g.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseEntity exercise;
  final String exerciseTimerText; // UI فقط
  final VoidCallback onStartPressed;
  final bool isRunning;
  ExerciseCard({
    super.key,
    required this.exercise,
    required this.exerciseTimerText,
    required this.onStartPressed,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // فيديو/صورة العنصر (Placeholder)
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: SizedBox(
              height: 280.h,
              child: Stack(
                children: [
                  exercise.videoUrl == null
                      ? AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            exercise.coverImage,
                            fit: BoxFit.cover,
                            loadingBuilder: (ctx, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (_, __, ___) => Container(
                              color: cs.surfaceVariant,
                              alignment: Alignment.center,
                              child: Icon(Icons.broken_image_outlined,
                                  size: 32.sp),
                            ),
                          ),
                        )
                      : ExerciseVideoPlayer(
                          videoUrl: exercise.videoUrl!,
                          title: exercise.name,
                        ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _FrostedChip(
                      icon: Icons.timer,
                      label: exerciseTimerText, // 00:00 عرض فقط
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // الاسم والوصف
          Text(
            exercise.name,
            style: AppText.s20W600,
          ),
          SizedBox(height: 6.h),
          Text(
            exercise.description,
            style: AppText.s13w600.copyWith(color: cs.onSurfaceVariant),
          ),

          SizedBox(height: 16.h),

          // الجولات والعدات
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10.r,
                  offset: Offset(0, 6.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.fitness_center_outlined,
                        size: 18.sp, color: cs.primary),
                    SizedBox(width: 6.w),
                    Text('${LocaleKeys.sets.tr()}: ${exercise.sets}',
                        style: AppText.s13w600),
                    SizedBox(width: 12.w),
                    Icon(Icons.repeat, size: 18.sp, color: cs.primary),
                    SizedBox(width: 6.w),
                    Text('${LocaleKeys.repetitions.tr()}: ${exercise.reps}',
                        style: AppText.s13w600),
                  ],
                ),
                SizedBox(height: 12.h),
                // Wrap(
                //   spacing: 8.w,
                //   runSpacing: 8.h,
                //   children: List.generate(
                //     exercise.sets,
                //     (i) => SetPill(index: i + 1, reps: exercise.reps),
                //   ),
                // ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // زر "ابدأ"
          SizedBox(
            height: 52.h,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
              ),
              onPressed: onStartPressed, // بدون منطق
              icon: Icon(Icons.play_circle_outline),
              label: Text(
                  isRunning ? LocaleKeys.stop.tr() : LocaleKeys.start.tr(),
                  style: AppText.s15w600),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _FrostedChip extends StatelessWidget {
  final IconData icon;
  final String label;
  _FrostedChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30.sp, color: Colors.white),
              SizedBox(width: 6.w),
              Text(
                label,
                style: AppText.s28W700.copyWith(
                  color: AppColors.primary,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
