import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';

class ProgressHeader extends StatelessWidget {
  final int totalExercises;
  final int currentIndex; // يبدأ من 1 للعرض
  final double progress; // 0..1
  final String globalTimerText; // UI فقط

  const ProgressHeader({
    super.key,
    required this.totalExercises,
    required this.currentIndex,
    required this.progress,
    required this.globalTimerText,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // مؤقت عام + عدّاد التمارين
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.timer_outlined,
                      size: 18.sp, color: cs.onPrimaryContainer),
                  SizedBox(width: 6.w),
                  Text(
                    globalTimerText,
                    style: AppText.s13w600.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              '${LocaleKeys.exercise.tr()} $currentIndex ${LocaleKeys.from.tr()} $totalExercises',
              style: AppText.s13w600,
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // شريط تقدم علوي
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            minHeight: 10.h,
            value: progress.clamp(0, 1),
            backgroundColor: cs.surfaceVariant.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
