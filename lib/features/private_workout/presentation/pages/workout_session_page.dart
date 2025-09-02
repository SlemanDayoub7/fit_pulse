import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/data_source/exercise_log_storage.dart';
import 'package:gym_app/features/private_workout/data/data_source/program_log_storage.dart';

import 'package:gym_app/features/private_workout/data/models/exercise.dart';
import 'package:gym_app/features/private_workout/data/models/program_log.dart';
import 'package:gym_app/features/private_workout/data/models/workout_day.dart';

class WorkoutSessionPage extends StatefulWidget {
  final String programId;
  final WorkoutDay workoutDay;

  const WorkoutSessionPage({
    super.key,
    required this.workoutDay,
    required this.programId,
  });

  @override
  State<WorkoutSessionPage> createState() => _WorkoutSessionPageState();
}

class _WorkoutSessionPageState extends State<WorkoutSessionPage> {
  int currentExerciseIndex = 0;
  int currentSetIndex = 0;
  List<List<double>> weightLogs = [];

  TextEditingController weightController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  Timer? roundTimer;
  Timer? restTimer;
  int roundSecondsLeft = 0;
  int restSecondsLeft = 30;
  bool isRoundStarted = false;
  bool isResting = false;

  @override
  void initState() {
    super.initState();
    _initializeWeightLogs();
  }

  void _initializeWeightLogs() {
    weightLogs = widget.workoutDay.exercises
        .map((exercise) => List.filled(exercise.sets, 0.0))
        .toList();
  }

  void _startRound() async {
    final weight = double.tryParse(weightController.text);
    final duration = int.tryParse(durationController.text);

    if (weight == null || duration == null) return;

    await _saveExerciseLog(weight);
    _updateWeightLogs(weight, duration);
    _startRoundTimer(duration);
  }

  Future<void> _saveExerciseLog(double weight) async {
    await ExerciseLogStorage.addLogEntry(
      widget.workoutDay.exercises[currentExerciseIndex].name,
      weight,
    );
  }

  void _updateWeightLogs(double weight, int duration) {
    setState(() {
      weightLogs[currentExerciseIndex][currentSetIndex] = weight;
      roundSecondsLeft = duration;
      isRoundStarted = true;
    });
  }

  void _startRoundTimer(int duration) {
    roundTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (roundSecondsLeft > 0) {
        setState(() => roundSecondsLeft--);
      } else {
        timer.cancel();
        _startRestTimer();
      }
    });
  }

  void _startRestTimer() {
    setState(() {
      isResting = true;
      restSecondsLeft =
          widget.workoutDay.exercises[currentExerciseIndex].restSeconds;
    });

    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restSecondsLeft > 0) {
        setState(() => restSecondsLeft--);
      } else {
        timer.cancel();
        _nextSet();
      }
    });
  }

  void _nextSet() {
    final totalSets = widget.workoutDay.exercises[currentExerciseIndex].sets;

    if (currentSetIndex + 1 < totalSets) {
      _moveToNextSet();
    } else if (currentExerciseIndex + 1 < widget.workoutDay.exercises.length) {
      _moveToNextExercise();
    } else {
      _showCompletionDialog();
    }
  }

  void _moveToNextSet() {
    setState(() {
      currentSetIndex++;
      _resetControllers();
      _resetTimers();
    });
  }

  void _moveToNextExercise() {
    setState(() {
      currentExerciseIndex++;
      currentSetIndex = 0;
      _resetControllers();
      _resetTimers();
    });
  }

  void _resetControllers() {
    weightController.clear();
    durationController.clear();
  }

  void _resetTimers() {
    setState(() {
      isRoundStarted = false;
      isResting = false;
    });
  }

  void _skipSet() {
    roundTimer?.cancel();
    restTimer?.cancel();
    _nextSet();
  }

  void _showCompletionDialog() async {
    _saveProgramLog();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text("تم التدريب بنجاح 🎉"),
        content: const Text("أحسنت! لقد أنهيت الجلسة بنجاح."),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("العودة للرئيسية"),
          ),
        ],
      ),
    );
  }

  void _saveProgramLog() {
    final programLog = ProgramLog(
      id: widget.programId,
      programName: "برنامج التمرين",
      date: DateTime.now(),
      exercises: widget.workoutDay.exercises
          .map(
            (exercise) => ExerciseLog(
              exerciseName: exercise.name,
              sets: List.generate(
                exercise.sets,
                (index) => SetLog(
                  reps: exercise.repsPerSet[index],
                  weight:
                      weightLogs[widget.workoutDay.exercises.indexOf(exercise)]
                          [index],
                ),
              ),
            ),
          )
          .toList(),
    );
    ProgramLogStorage.addLog(programLog);
  }

  @override
  void dispose() {
    roundTimer?.cancel();
    restTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.workoutDay.exercises[currentExerciseIndex];
    final reps = exercise.repsPerSet[currentSetIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProgressIndicator(),
              _buildExerciseCard(exercise, reps),
              SizedBox(height: 24.h),
              _buildTimerIndicator(),
              SizedBox(height: 24.h),
              _buildInputFields(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("جلسة التدريب"),
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16.r),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          Text(
            'التقدم العام',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value:
                (currentExerciseIndex + 1) / widget.workoutDay.exercises.length,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
            minHeight: 12.h,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise, int reps) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Text(
              exercise.name,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInfoChip(
                  icon: Icons.repeat,
                  label: '${currentSetIndex + 1}/${exercise.sets}',
                ),
                SizedBox(width: 16.w),
                _buildInfoChip(
                  icon: Icons.fitness_center,
                  label: '$reps عدات',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerIndicator() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: _getTimerProgressValue(),
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(
              isResting ? AppColors.warning : AppColors.secondary,
            ),
            strokeWidth: 8.w,
          ),
          Text(
            _getTimerText(),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  double _getTimerProgressValue() {
    if (isRoundStarted) {
      return roundSecondsLeft / int.parse(durationController.text);
    } else if (isResting) {
      return restSecondsLeft / 30;
    }
    return 0;
  }

  String _getTimerText() {
    if (isResting) return '$restSecondsLeft';
    if (isRoundStarted) return '$roundSecondsLeft';
    return 'ابدأ';
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        _buildInputField(
          controller: weightController,
          label: 'الوزن المستخدم (كغ)',
          icon: Icons.monitor_weight,
          enabled: !isResting && !isRoundStarted,
        ),
        SizedBox(height: 16.h),
        _buildInputField(
          controller: durationController,
          label: 'مدة الجولة (ثواني)',
          icon: Icons.timer,
          enabled: !isResting && !isRoundStarted,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.border),
        ),
        filled: true,
        fillColor: enabled ? AppColors.surface : AppColors.background,
      ),
      style: TextStyle(color: AppColors.textPrimary),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconButton(
            icon: Icons.skip_next,
            label: 'تخطي',
            color: AppColors.warning,
            onPressed: _skipSet,
          ),
          _buildIconButton(
            icon: isRoundStarted ? Icons.pause : Icons.play_arrow,
            label: isRoundStarted ? 'إيقاف' : 'ابدأ',
            color: AppColors.secondary,
            onPressed: isRoundStarted ? _pauseRound : _startRound,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        IconButton.filled(
          iconSize: 32.w,
          onPressed: onPressed,
          icon: Icon(icon, color: AppColors.white),
          style: IconButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(16.w),
          ),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(color: color, fontSize: 12.sp)),
      ],
    );
  }

  void _pauseRound() {
    roundTimer?.cancel();
    restTimer?.cancel();
    setState(() => isRoundStarted = false);
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Chip(
      backgroundColor: AppColors.surface,
      avatar: Icon(icon, size: 18.w, color: AppColors.textSecondary),
      label: Text(
        label,
        style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: AppColors.border),
      ),
    );
  }
}
