// workout_plan_event.dart

import 'package:equatable/equatable.dart';

abstract class WorkoutPlanEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to load list of plans
class LoadWorkoutPlans extends WorkoutPlanEvent {}

// (Optional) keep LoadWorkoutPlan for single plan if needed
class LoadWorkoutPlan extends WorkoutPlanEvent {
  final int id;
  LoadWorkoutPlan(this.id);

  @override
  List<Object?> get props => [id];
}
