import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_text.dart';

import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/core/widgets/toasts/toast_helper.dart';
import 'package:gym_app/features/workout_session/presentation/cubit/workout_session_cubit.dart';
import 'package:gym_app/features/workout_session/presentation/cubit/workout_session_state.dart';
import 'package:gym_app/features/workout_session/presentation/pages/rest_timer_page.dart';
import 'package:gym_app/features/workout_session/presentation/widgets/exercies_card.dart';
import 'package:gym_app/features/workout_session/presentation/widgets/progress_header.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';

class WorkoutSessionPage extends StatefulWidget {
  const WorkoutSessionPage({super.key});

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.workout_session.tr(), style: AppText.s18W700),
      ),
      body: SafeArea(
        child: BlocConsumer<WorkoutSessionCubit, WorkoutSessionState>(
          listenWhen: (previous, current) =>
              previous.currentExerciseIndex != current.currentExerciseIndex,
          listener: (context, state) {
            _pageController.animateToPage(
              state.currentExerciseIndex,
              duration: const Duration(milliseconds: 450),
              curve: Curves.easeInOutCubic,
            );
          },
          builder: (context, state) {
            final cubit = context.read<WorkoutSessionCubit>();
            final totalExercises = cubit.exercises.length;
            final currentIndex = state.currentExerciseIndex;
            final currentExercise = cubit.exercises[currentIndex];
            final completedSets = state.completedSets[currentIndex];
            final totalSets = currentExercise.sets;

            return Column(
              children: [
                // رأس الجلسة: شريط التقدم + المؤقت العام
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: ProgressHeader(
                    totalExercises: totalExercises,
                    currentIndex: currentIndex + 1,
                    progress: (currentIndex + 1) / totalExercises,
                    globalTimerText: _formatDuration(state.globalDuration),
                  ),
                ),

                // محتوى التمرين
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: totalExercises,
                    itemBuilder: (context, i) {
                      final e = cubit.exercises[i];
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        child: ExerciseCard(
                          isRunning: cubit.isExercisesRunning,
                          key: ValueKey(e.id),
                          exercise: e,
                          exerciseTimerText:
                              _formatDuration(state.exerciseDuration),
                          onStartPressed: () {
                            setState(() {
                              print(cubit.isExercisesRunning);
                              if (cubit.isExercisesRunning)
                                cubit.pauseExercise();
                              else
                                cubit.startExercise();
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                // معلومات الجولات

                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    children: [
                      Text(
                        '${LocaleKeys.round.tr()} ${completedSets + 1} ${LocaleKeys.from.tr()} $totalSets',
                        style: AppText.s16W600,
                      ),
                      SizedBox(height: 8.h),
                      LinearProgressIndicator(
                        value: (completedSets / totalSets).clamp(0, 1),
                        color: cs.primary,
                        backgroundColor: cs.surfaceVariant,
                        minHeight: 8.h,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      SizedBox(height: 12.h),
                      if (cubit.isExercisesRunning)
                        AppButton(
                          maxWidth: double.infinity,
                          onPressed: () async {
                            print(completedSets);

                            completedSets < totalSets
                                ? cubit.finishSet(autoAdvance: true)
                                : null;

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestTimerPage(),
                              ),
                            );
                            print(completedSets);
                            if ((completedSets + 1 == totalSets) &&
                                (totalExercises == currentIndex + 1))
                              Navigator.pop(
                                context,
                              );
                          },
                          title: LocaleKeys.finish_round.tr(),
                        ),
                    ],
                  ),
                ),

                // // أزرار التنقل بين التمارين
                // Padding(
                //   padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: _NavButton(
                //           label: LocaleKeys.previous.tr(),
                //           icon: Icons.arrow_back,
                //           enabled: currentIndex > 0,
                //           onTap: cubit.previousExercise,
                //         ),
                //       ),
                //       SizedBox(width: 12.w),
                //       Expanded(
                //         child: _NavButton(
                //             label: currentIndex == totalExercises - 1
                //                 ? LocaleKeys.finish.tr()
                //                 : LocaleKeys.next.tr(),
                //             icon: currentIndex == totalExercises - 1
                //                 ? Icons.flag_outlined
                //                 : Icons.arrow_forward,
                //             enabled: true,
                //             onTap: () {
                //               print(completedSets);
                //               print(totalSets);
                //               completedSets == totalSets
                //                   ? (currentIndex == totalExercises - 1
                //                       ? cubit.finishSet
                //                       : cubit.nextExercise)
                //                   : ToastHelper.showAppBottomSheetToast(context,
                //                       LocaleKeys.you_must_complete_rounds.tr());
                //             }),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class _NavButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;
  const _NavButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.enabled ? widget.onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: widget.enabled ? cs.primary : cs.surfaceVariant,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            if (!_pressed)
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10.r,
                offset: Offset(0, 6.h),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon,
                size: 20.sp,
                color: widget.enabled ? Colors.white : cs.onSurfaceVariant),
            SizedBox(width: 8.w),
            Text(
              widget.label,
              style: AppText.s14w600.copyWith(
                color: widget.enabled ? Colors.white : cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
