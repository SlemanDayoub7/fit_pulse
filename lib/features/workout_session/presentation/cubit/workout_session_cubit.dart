// =============================
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/workout_session/domain/entities/exercise.dart';
import 'package:gym_app/features/workout_session/presentation/cubit/workout_session_state.dart';
import 'package:gym_app/features/workout_session/presentation/pages/workout_session_page.dart';

class WorkoutSessionCubit extends Cubit<WorkoutSessionState> {
  final List<ExerciseEntity> exercises;

  Timer? _globalTimer;
  Timer? _exerciseTimer;
  bool isExercisesRunning = false;

  WorkoutSessionCubit({required this.exercises})
      : super(WorkoutSessionState.initial(exercises.length));

  // -------------------- Session control --------------------
  void startSession() {
    if (state.status == WorkoutStatus.running) return;
    _startGlobalTimer();
    emit(state.copyWith(status: WorkoutStatus.running));
  }

  void _startGlobalTimer() {
    _globalTimer?.cancel();
    _globalTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      emit(state.copyWith(
          globalDuration: state.globalDuration + const Duration(seconds: 1)));
    });
  }

  // -------------------- Exercise control --------------------
  /// Start the current exercise's timer. If [index] is provided, jump to it first.
  void startExercise({int? index}) {
    // if (index != null) {
    //   if (index < 0 || index >= exercises.length) return;
    //   _goTo(index);
    // }

    // // Ensure session running
    if (state.status != WorkoutStatus.running) startSession();

    // if (state.isExerciseRunning) return;

    // // Reset exercise timer for fresh start

    isExercisesRunning = true;
    _exerciseTimer?.cancel();
    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      emit(state.copyWith(
          exerciseDuration:
              state.exerciseDuration + const Duration(seconds: 1)));
    });
  }

  void pauseExercise() {
    isExercisesRunning = false;
    _exerciseTimer?.cancel();
    _exerciseTimer = null;
  }

  /// Mark one set as finished for the current exercise.
  /// If [autoAdvance] true and all sets done, automatically move to next exercise.
  void finishSet({bool autoAdvance = false}) {
    final idx = state.currentExerciseIndex;
    final completed = List<int>.from(state.completedSets);
    completed[idx] = (completed[idx] + 1).clamp(0, exercises[idx].sets);

    // detect if exercise done
    final isDone = completed[idx] >= exercises[idx].sets;
    final doneFlags = List<bool>.from(state.exerciseCompleted);
    if (isDone) doneFlags[idx] = true;

    // Stop exercise timer and reset its duration (UI will show last duration if you prefer)
    _exerciseTimer?.cancel();
    _exerciseTimer = null;

    emit(state.copyWith(
      completedSets: completed,
      exerciseCompleted: doneFlags,
      isExerciseRunning: false,
      exerciseDuration: Duration.zero,
    ));
    isExercisesRunning = false;
    if (isDone && autoAdvance) {
      nextExercise();
    }
  }

  void nextExercise() {
    if (state.currentExerciseIndex >= exercises.length - 1) {
      _completeSession();
      return;
    }

    final next = state.currentExerciseIndex + 1;
    emit(state.copyWith(
        currentExerciseIndex: next,
        exerciseDuration: Duration.zero,
        isExerciseRunning: false));
  }

  void previousExercise() {
    if (state.currentExerciseIndex <= 0) return;
    final prev = state.currentExerciseIndex - 1;
    emit(state.copyWith(
        currentExerciseIndex: prev,
        exerciseDuration: Duration.zero,
        isExerciseRunning: false));
  }

  void goToExercise(int index) {
    if (index < 0 || index >= exercises.length) return;
    _goTo(index);
  }

  void _goTo(int index) {
    // Cancel running exercise timer when we jump
    _exerciseTimer?.cancel();
    _exerciseTimer = null;
    emit(state.copyWith(
        currentExerciseIndex: index,
        exerciseDuration: Duration.zero,
        isExerciseRunning: false));
  }

  // -------------------- Session completion / reset --------------------
  void _completeSession() {
    _globalTimer?.cancel();
    _exerciseTimer?.cancel();
    _globalTimer = null;
    _exerciseTimer = null;
    emit(state.copyWith(
        status: WorkoutStatus.finished, isExerciseRunning: false));
  }

  void resetSession() {
    _globalTimer?.cancel();
    _exerciseTimer?.cancel();
    _globalTimer = null;
    _exerciseTimer = null;
    emit(WorkoutSessionState.initial(exercises.length));
  }

  @override
  Future<void> close() {
    _globalTimer?.cancel();
    _exerciseTimer?.cancel();
    return super.close();
  }
}
