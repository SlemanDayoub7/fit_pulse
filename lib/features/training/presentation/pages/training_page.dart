import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/features/training/presentation/bloc/training_bloc.dart';
import 'package:gym_app/features/training/presentation/bloc/training_event.dart';
import 'package:gym_app/features/training/presentation/bloc/training_state.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<TrainingBloc, TrainingState>(
            builder: (context, state) {
              if (state is TrainingInProgress) {
                final exercise = context
                    .read<TrainingBloc>()
                    .exercises[state.currentExerciseIndex];

                final double workoutProgress = ((state.currentExerciseIndex +
                        (state.currentSet - 1) / state.totalSets) /
                    context.read<TrainingBloc>().exercises.length);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Animated gradient progress bar
                    AnimatedGradientProgressBar(progress: workoutProgress),
                    SizedBox(height: 16.h),

                    Text(
                      state.isOnRest
                          ? "Rest Time"
                          : (exercise.nameEn ?? "Exercise"),
                      style: AppText.s22W600,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),

                    // Animated circular timer with breathing effect
                    Center(
                      child: CircularTimer(
                        progress: state.isOnRest
                            ? state.restTimeLeft / 30
                            : (exercise.time! - state.exerciseTimeElapsed) /
                                exercise.time!,
                        timeLeft: state.isOnRest
                            ? _formatTime(state.restTimeLeft)
                            : _formatTime(state.exerciseTimeRemaining),
                        isRunning: state.isExerciseRunning && !state.isOnRest,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    if (!state.isOnRest) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Set: ${state.currentSet}/${state.totalSets}",
                              style: AppText.s18W500),
                          Row(
                            children: [
                              AnimatedIconButton(
                                icon: Icons.remove,
                                color: AppColors.red,
                                onPressed: () => context
                                    .read<TrainingBloc>()
                                    .add(DecrementReps()),
                              ),
                              SizedBox(width: 8.w),
                              Text('${state.repsDone} / ${exercise.reps}',
                                  style: AppText.s18W500),
                              SizedBox(width: 8.w),
                              AnimatedIconButton(
                                icon: Icons.add,
                                color: AppColors.success,
                                onPressed: () => context
                                    .read<TrainingBloc>()
                                    .add(IncrementReps()),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],

                    SizedBox(height: 16.h),

                    // Controls with animated button press effects
                    if (!state.isOnRest) ...[
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              title:
                                  state.isExerciseRunning ? "Pause" : "Start",
                              child: Icon(state.isExerciseRunning
                                  ? Icons.pause
                                  : Icons.play_arrow),
                              onPressed: () {
                                if (state.isExerciseRunning) {
                                  context
                                      .read<TrainingBloc>()
                                      .add(PauseExerciseTimer());
                                } else {
                                  context
                                      .read<TrainingBloc>()
                                      .add(StartExerciseTimer());
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: AppButton(
                              title: "Finish Set",
                              child: Icon(Icons.check),
                              onPressed: () =>
                                  context.read<TrainingBloc>().add(FinishSet()),
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      AppButton(
                        title: "Skip Rest",
                        child: Icon(Icons.fast_forward),
                        onPressed: () =>
                            context.read<TrainingBloc>().add(SkipRest()),
                      ),
                    ],
                    SizedBox(height: 12.h),

                    // Skip Exercise
                    AppButton(
                      title: "Skip Exercise",
                      child: Icon(Icons.skip_next),
                      onPressed: () =>
                          context.read<TrainingBloc>().add(SkipExercise()),
                    ),

                    SizedBox(height: 24.h),
                    Text("Total Time: ${_formatTime(state.totalTimeElapsed)}",
                        style: AppText.s16W500.copyWith(color: Colors.grey)),
                  ],
                );
              } else if (state is TrainingCompleted) {
                return Center(
                  child: Text("Workout Completed!",
                      style:
                          TextStyle(fontSize: 24.sp, color: AppColors.success)),
                );
              } else {
                return Center(
                  child: AppButton(
                    title: "ابدأ التمرين",
                    onPressed: () =>
                        context.read<TrainingBloc>().add(StartExerciseTimer()),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class AnimatedGradientProgressBar extends StatefulWidget {
  final double progress;
  const AnimatedGradientProgressBar({required this.progress, Key? key})
      : super(key: key);

  @override
  State<AnimatedGradientProgressBar> createState() =>
      _AnimatedGradientProgressBarState();
}

class _AnimatedGradientProgressBarState
    extends State<AnimatedGradientProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Container(
                height: 12.h,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
              FractionallySizedBox(
                widthFactor: widget.progress.clamp(0.0, 1.0),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.success,
                        AppColors.primary
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: Alignment(-1 + 2 * _animation.value, 0),
                      end: Alignment(1 + 2 * _animation.value, 0),
                    ).createShader(rect);
                  },
                  child: Container(
                    height: 12.h,
                    color: Colors.white,
                  ),
                  blendMode: BlendMode.srcATop,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircularTimer extends StatefulWidget {
  final double progress;
  final String timeLeft;
  final bool isRunning;

  const CircularTimer({
    required this.progress,
    required this.timeLeft,
    this.isRunning = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  @override
  void initState() {
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
    );
    if (widget.isRunning) {
      _breathingController.repeat(reverse: true);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircularTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning && !_breathingController.isAnimating) {
      _breathingController.repeat(reverse: true);
    } else if (!widget.isRunning && _breathingController.isAnimating) {
      _breathingController.stop();
      _breathingController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: widget.progress),
      duration: const Duration(milliseconds: 400),
      builder: (_, value, __) {
        return ScaleTransition(
          scale: _breathingController,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
              Text(
                widget.timeLeft,
                style: AppText.s22W600.copyWith(
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: AppColors.primary.withOpacity(0.6),
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const AnimatedIconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1, end: 0.85)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    super.initState();
  }

  void _onTapDown(_) {
    _controller.forward();
  }

  void _onTapUp(_) {
    _controller.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scale,
        child: Icon(widget.icon, color: widget.color, size: 28.sp),
      ),
    );
  }
}
