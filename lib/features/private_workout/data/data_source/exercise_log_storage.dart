import 'dart:convert';
import 'package:gym_app/features/private_workout/data/models/exercise_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseLogStorage {
  static const _key = 'exercise_logs';

  static Future<void> saveLogs(List<ExerciseLog> logs) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = logs.map((log) => jsonEncode(log.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  static Future<List<ExerciseLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => ExerciseLog.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> addLogEntry(String exerciseName, double weight) async {
    final logs = await loadLogs();
    final now = DateTime.now();

    final index = logs.indexWhere((log) => log.exerciseName == exerciseName);

    if (index >= 0) {
      logs[index].entries.add(ExerciseLogEntry(date: now, weight: weight));
    } else {
      logs.add(
        ExerciseLog(
          exerciseName: exerciseName,
          entries: [ExerciseLogEntry(date: now, weight: weight)],
        ),
      );
    }

    await saveLogs(logs);
  }
}
