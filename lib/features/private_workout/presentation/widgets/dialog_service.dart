// dialog_service.dart
import 'package:flutter/material.dart';
import 'package:gym_app/features/private_workout/data/models/exercise.dart';
import 'package:gym_app/features/private_workout/data/models/workout_day.dart';
import 'package:gym_app/features/private_workout/presentation/widgets/exercise_dialog.dart';
import 'workout_day_dialog.dart';

class DialogService {
  static void showWorkoutDayDialog({
    required BuildContext context,
    required Function(WorkoutDay) onDayAdded,
  }) {
    showDialog(
      context: context,
      builder: (_) => WorkoutDayDialog(onDayAdded: onDayAdded),
    );
  }

  static void showExerciseDialog({
    required BuildContext context,
    required Function(Exercise) onExerciseAdded,
  }) {
    showDialog(
      context: context,
      builder: (_) => ExerciseDialog(onExerciseAdded: onExerciseAdded),
    );
  }
}
