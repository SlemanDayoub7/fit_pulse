import 'package:equatable/equatable.dart';

enum WorkoutStatus { idle, running, paused, finished }

class WorkoutSessionState extends Equatable {
  final WorkoutStatus status;
  final int currentExerciseIndex;
  final List<int> completedSets; // number of completed sets per exercise
  final List<bool>
      exerciseCompleted; // whether full exercise (all sets) is done
  final Duration globalDuration;
  final Duration exerciseDuration;
  final bool isExerciseRunning;

  const WorkoutSessionState({
    required this.status,
    required this.currentExerciseIndex,
    required this.completedSets,
    required this.exerciseCompleted,
    required this.globalDuration,
    required this.exerciseDuration,
    required this.isExerciseRunning,
  });

  factory WorkoutSessionState.initial(int exercisesCount) =>
      WorkoutSessionState(
        status: WorkoutStatus.idle,
        currentExerciseIndex: 0,
        completedSets: List<int>.filled(exercisesCount, 0, growable: false),
        exerciseCompleted:
            List<bool>.filled(exercisesCount, false, growable: false),
        globalDuration: Duration.zero,
        exerciseDuration: Duration.zero,
        isExerciseRunning: false,
      );

  WorkoutSessionState copyWith({
    WorkoutStatus? status,
    int? currentExerciseIndex,
    List<int>? completedSets,
    List<bool>? exerciseCompleted,
    Duration? globalDuration,
    Duration? exerciseDuration,
    bool? isExerciseRunning,
  }) {
    return WorkoutSessionState(
      status: status ?? this.status,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
      completedSets: completedSets ?? List<int>.from(this.completedSets),
      exerciseCompleted:
          exerciseCompleted ?? List<bool>.from(this.exerciseCompleted),
      globalDuration: globalDuration ?? this.globalDuration,
      exerciseDuration: exerciseDuration ?? this.exerciseDuration,
      isExerciseRunning: isExerciseRunning ?? this.isExerciseRunning,
    );
  }

  @override
  List<Object> get props => [
        status,
        currentExerciseIndex,
        ...completedSets,
        ...exerciseCompleted,
        globalDuration,
        exerciseDuration
      ];
}
