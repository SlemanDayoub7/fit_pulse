// program_log.dart
import 'dart:convert';

class ProgramLog {
  final String programName; // اسم البرنامج التدريبي
  final DateTime date; // تاريخ تنفيذ البرنامج التدريبي
  final List<ExerciseLog> exercises; // قائمة تحتوي على التمارين التي تم تنفيذها
  final String id;
  ProgramLog({
    required this.id,
    required this.programName,
    required this.date,
    required this.exercises,
  });

  Map<String, dynamic> toJson() {
    return {
      'programName': programName,
      'date': date.toIso8601String(),
      'id': id,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }

  factory ProgramLog.fromJson(Map<String, dynamic> json) {
    return ProgramLog(
      id: json['id'],
      programName: json['programName'],
      date: DateTime.parse(json['date']),
      exercises: (json['exercises'] as List)
          .map((exerciseJson) => ExerciseLog.fromJson(exerciseJson))
          .toList(),
    );
  }
}

class ExerciseLog {
  final String exerciseName;
  final List<SetLog> sets;

  ExerciseLog({
    required this.exerciseName,
    required this.sets,
  });

  Map<String, dynamic> toJson() {
    return {
      'exerciseName': exerciseName,
      'sets': sets.map((set) => set.toJson()).toList(),
    };
  }

  factory ExerciseLog.fromJson(Map<String, dynamic> json) {
    return ExerciseLog(
      exerciseName: json['exerciseName'],
      sets: (json['sets'] as List)
          .map((setJson) => SetLog.fromJson(setJson))
          .toList(),
    );
  }
}

class SetLog {
  final int reps;
  final double weight;

  SetLog({required this.reps, required this.weight});

  Map<String, dynamic> toJson() => {
        'reps': reps,
        'weight': weight,
      };

  factory SetLog.fromJson(Map<String, dynamic> json) => SetLog(
        reps: json['reps'],
        weight: json['weight'].toDouble(),
      );
}
