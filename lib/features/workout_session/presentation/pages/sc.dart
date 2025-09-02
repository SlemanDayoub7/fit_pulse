import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/workout_session/domain/entities/exercise.dart';
import 'package:gym_app/features/workout_session/presentation/cubit/workout_session_cubit.dart';
import 'package:gym_app/features/workout_session/presentation/pages/workout_session_page.dart';

class WorkoutSessionScreen extends StatelessWidget {
  final List<ExerciseEntity> exercises;
  const WorkoutSessionScreen({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkoutSessionCubit(exercises: exercises),
      child: const WorkoutSessionPage(),
    );
  }
}
