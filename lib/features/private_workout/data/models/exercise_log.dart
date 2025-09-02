class ExerciseLogEntry {
  final DateTime date;
  final double weight;

  ExerciseLogEntry({
    required this.date,
    required this.weight,
  });

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'weight': weight,
      };

  factory ExerciseLogEntry.fromJson(Map<String, dynamic> json) =>
      ExerciseLogEntry(
        date: DateTime.parse(json['date']),
        weight: (json['weight'] as num).toDouble(),
      );
}

class ExerciseLog {
  final String exerciseName;
  final List<ExerciseLogEntry> entries;

  ExerciseLog({
    required this.exerciseName,
    required this.entries,
  });

  double get averageWeight => entries.isEmpty
      ? 0
      : entries.map((e) => e.weight).reduce((a, b) => a + b) / entries.length;

  double get maxWeight => entries.isEmpty
      ? 0
      : entries.map((e) => e.weight).reduce((a, b) => a > b ? a : b);

  double get minWeight => entries.isEmpty
      ? 0
      : entries.map((e) => e.weight).reduce((a, b) => a < b ? a : b);

  Map<String, dynamic> toJson() => {
        'exerciseName': exerciseName,
        'entries': entries.map((e) => e.toJson()).toList(),
      };

  factory ExerciseLog.fromJson(Map<String, dynamic> json) => ExerciseLog(
        exerciseName: json['exerciseName'],
        entries: (json['entries'] as List)
            .map((e) => ExerciseLogEntry.fromJson(e))
            .toList(),
      );
}
