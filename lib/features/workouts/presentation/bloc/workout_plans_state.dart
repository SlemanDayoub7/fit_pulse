// workout_plan_state.dart

import 'package:equatable/equatable.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';

abstract class WorkoutPlanState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WorkoutPlanInitial extends WorkoutPlanState {}

class WorkoutPlanLoading extends WorkoutPlanState {}

class WorkoutPlansLoaded extends WorkoutPlanState {
  final List<WorkoutPlan> workoutPlans;

  WorkoutPlansLoaded(this.workoutPlans);

  @override
  List<Object?> get props => [workoutPlans];
}

class WorkoutPlanLoaded extends WorkoutPlanState {
  final WorkoutPlan workoutPlan;

  WorkoutPlanLoaded(this.workoutPlan);

  @override
  List<Object?> get props => [workoutPlan];
}

class WorkoutPlanError extends WorkoutPlanState {
  final String message;

  WorkoutPlanError(this.message);

  @override
  List<Object?> get props => [message];
}
