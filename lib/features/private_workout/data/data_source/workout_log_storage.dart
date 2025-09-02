import 'dart:convert';
import 'package:gym_app/features/private_workout/data/models/workout_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutLogStorage {
  static const _key = 'workout_logs';

  static Future<void> saveLogs(List<WorkoutLog> logs) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = logs.map((log) => jsonEncode(log.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  static Future<List<WorkoutLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => WorkoutLog.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> addLog(WorkoutLog log) async {
    final logs = await loadLogs();
    logs.add(log);
    await saveLogs(logs);
  }
}
