import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/private_workout/data/models/workout_program.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkoutProgramCubit extends Cubit<List<WorkoutProgram>> {
  WorkoutProgramCubit() : super([]);

  void addProgram(WorkoutProgram program) {
    final updated = [...state, program];
    emit(updated);
    saveToLocal(updated);
  }

  void deleteProgram(int index) {
    final updated = [...state]..removeAt(index);
    emit(updated);
    saveToLocal(updated);
  }

  void updateProgram(int index, WorkoutProgram updatedProgram) {
    final updated = [...state];
    updated[index] = updatedProgram;
    emit(updated);
    saveToLocal(updated);
  }

  void saveToLocal(List<WorkoutProgram> programs) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(programs.map((e) => e.toMap()).toList());
    await prefs.setString('programs', encoded);
  }

  void loadFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('programs');
    if (json != null) {
      final list = (jsonDecode(json) as List)
          .map((e) => WorkoutProgram.fromMap(e))
          .toList();
      emit(list);
    }
  }
}
