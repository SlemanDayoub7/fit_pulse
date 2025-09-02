abstract class WorkoutEvent {}

class StartWorkout extends WorkoutEvent {}

class StartSet extends WorkoutEvent {}

class PauseSet extends WorkoutEvent {}

class ResumeSet extends WorkoutEvent {}

class CompleteSet extends WorkoutEvent {}

class SkipExercise extends WorkoutEvent {}

class EndWorkout extends WorkoutEvent {}

class UpdateWeight extends WorkoutEvent {
  final String weight;

  UpdateWeight(this.weight);
}
