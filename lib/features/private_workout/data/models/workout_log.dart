class WorkoutLog {
  final String exerciseName;
  final DateTime date;
  final List<SetLog> sets;

  WorkoutLog({
    required this.exerciseName,
    required this.date,
    required this.sets,
  });

  Map<String, dynamic> toJson() => {
        'exerciseName': exerciseName,
        'date': date.toIso8601String(),
        'sets': sets.map((e) => e.toJson()).toList(),
      };

  factory WorkoutLog.fromJson(Map<String, dynamic> json) => WorkoutLog(
        exerciseName: json['exerciseName'],
        date: DateTime.parse(json['date']),
        sets: (json['sets'] as List).map((e) => SetLog.fromJson(e)).toList(),
      );
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
