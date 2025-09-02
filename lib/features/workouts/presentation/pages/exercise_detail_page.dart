import 'package:flutter/material.dart';
import 'package:gym_app/features/workouts/presentation/widgets/exercise_detail/exercise_detail_page_body.dart';
import '../../data/models/response_models/workout_plan.dart';

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;
  final String reps;
  final String sets;

  const ExerciseDetailPage({
    super.key,
    required this.exercise,
    required this.reps,
    required this.sets,
  });

  @override
  Widget build(BuildContext context) {
    return ExerciseDetailPageBody(
      exercise: exercise,
      reps: reps,
      sets: sets,
    );
  }
}
