abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutInProgress extends WorkoutState {
  final int currentExerciseIndex;
  final int currentSetIndex;
  final int remainingTime;
  final bool isRunning;
  final String weightInput;

  WorkoutInProgress({
    required this.currentExerciseIndex,
    required this.currentSetIndex,
    required this.remainingTime,
    required this.isRunning,
    required this.weightInput,
  });

  WorkoutInProgress copyWith({
    int? currentExerciseIndex,
    int? currentSetIndex,
    int? remainingTime,
    bool? isRunning,
    String? weightInput,
  }) {
    return WorkoutInProgress(
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      currentSetIndex: currentSetIndex ?? this.currentSetIndex,
      remainingTime: remainingTime ?? this.remainingTime,
      isRunning: isRunning ?? this.isRunning,
      weightInput: weightInput ?? this.weightInput,
    );
  }
}

class WorkoutPaused extends WorkoutState {}

class WorkoutCompleted extends WorkoutState {}

class WorkoutError extends WorkoutState {
  final String message;

  WorkoutError(this.message);
}
