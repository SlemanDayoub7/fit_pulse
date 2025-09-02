import 'package:gym_app/features/private_workout/data/models/exercise.dart';
import 'package:gym_app/features/workout_session/data/models/exercies_set_progress.dart';

class ExerciseProgress {
  final Exercise exercise;
  final List<ExerciseSetProgress> setsProgress;
  int currentSetIndex;

  ExerciseProgress({
    required this.exercise,
    required this.setsProgress,
    this.currentSetIndex = 0,
  });

  bool get isCompleted => setsProgress.every((set) => set.completed);
}
