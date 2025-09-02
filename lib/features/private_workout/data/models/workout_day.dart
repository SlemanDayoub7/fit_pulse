import 'package:gym_app/features/private_workout/data/models/exercise.dart';

class WorkoutDay {
  final String dayOfWeek;
  final String targetMuscles;
  final List<Exercise> exercises;

  WorkoutDay({
    required this.dayOfWeek,
    required this.targetMuscles,
    required this.exercises,
  });

  Map<String, dynamic> toJson() => {
        'dayOfWeek': dayOfWeek,
        'targetMuscles': targetMuscles,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };

  factory WorkoutDay.fromJson(Map<String, dynamic> json) => WorkoutDay(
        dayOfWeek: json['dayOfWeek'],
        targetMuscles: json['targetMuscles'],
        exercises: (json['exercises'] as List)
            .map((e) => Exercise.fromJson(e))
            .toList(),
      );
}
