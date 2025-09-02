// program_log_storage.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gym_app/features/private_workout/data/models/program_log.dart';

class ProgramLogStorage {
  static const _key = 'program_logs';

  static Future<void> saveLogs(List<ProgramLog> logs) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = logs.map((log) => jsonEncode(log.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  static Future<List<ProgramLog>> loadLogs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data.map((e) => ProgramLog.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> addLog(ProgramLog log) async {
    var logs = await loadLogs();
    ProgramLog? oldLog = logs.where((p) => p.id == log.id).firstOrNull;
    logs.removeWhere((p) => p.id == log.id);
    if (oldLog != null) {
      oldLog.exercises.addAll(log.exercises);
      logs.add(oldLog);
    } else {
      logs.add(log);
    }
    await saveLogs(logs);
  }
}
