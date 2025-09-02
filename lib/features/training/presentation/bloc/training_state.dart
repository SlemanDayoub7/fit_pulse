abstract class TrainingState {}

class TrainingInitial extends TrainingState {}

class TrainingCompleted extends TrainingState {}

class TrainingInProgress extends TrainingState {
  final int currentExerciseIndex;
  final int currentSet;
  final int totalSets;
  final int exerciseTimeElapsed;
  final int exerciseTimeRemaining;
  final int totalTimeElapsed;
  final bool isExerciseRunning;
  final bool isOnRest;
  final int restTimeLeft;
  final int repsDone;

  TrainingInProgress({
    required this.currentExerciseIndex,
    required this.currentSet,
    required this.totalSets,
    required this.exerciseTimeElapsed,
    required this.exerciseTimeRemaining,
    required this.totalTimeElapsed,
    required this.isExerciseRunning,
    required this.isOnRest,
    required this.restTimeLeft,
    required this.repsDone,
  });
}
