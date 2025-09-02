import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/private_workout/data/models/workout_day.dart';
import 'package:gym_app/features/workout_session/presentation/bloc/workout_session_event.dart';
import 'package:gym_app/features/workout_session/presentation/bloc/workout_session_state.dart';

import 'package:bloc/bloc.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final WorkoutDay workoutDay;

  WorkoutBloc({required this.workoutDay}) : super(WorkoutInitial()) {
    on<StartWorkout>(_onStartWorkout);
    on<StartSet>(_onStartSet);
    on<PauseSet>(_onPauseSet);
    on<ResumeSet>(_onResumeSet);
    on<CompleteSet>(_onCompleteSet);
    on<SkipExercise>(_onSkipExercise);
    on<EndWorkout>(_onEndWorkout);
    on<UpdateWeight>(_onUpdateWeight);
  }

  void _onStartWorkout(StartWorkout event, Emitter<WorkoutState> emit) {
    emit(WorkoutInProgress(
      currentExerciseIndex: 0,
      currentSetIndex: 0,
      remainingTime: workoutDay.exercises[0].restSeconds,
      isRunning: false,
      weightInput: '',
    ));
  }

  void _onStartSet(StartSet event, Emitter<WorkoutState> emit) {
    if (state is WorkoutInProgress) {
      final currentState = state as WorkoutInProgress;
      emit(currentState.copyWith(isRunning: true));
      _startTimer(currentState, emit);
    }
  }

  void _onPauseSet(PauseSet event, Emitter<WorkoutState> emit) {
    if (state is WorkoutInProgress) {
      final currentState = state as WorkoutInProgress;
      emit(currentState.copyWith(isRunning: false));
    }
  }

  void _onResumeSet(ResumeSet event, Emitter<WorkoutState> emit) {
    if (state is WorkoutInProgress) {
      final currentState = state as WorkoutInProgress;
      emit(currentState.copyWith(isRunning: true));
      _startTimer(currentState, emit);
    }
  }

  void _onCompleteSet(CompleteSet event, Emitter<WorkoutState> emit) {
    if (state is WorkoutInProgress) {
      final currentState = state as WorkoutInProgress;
      if (currentState.currentSetIndex <
          workoutDay.exercises[currentState.currentExerciseIndex].sets - 1) {
        emit(currentState.copyWith(
          currentSetIndex: currentState.currentSetIndex + 1,
          remainingTime: workoutDay
              .exercises[currentState.currentExerciseIndex].restSeconds,
          isRunning: false,
        ));
      } else {
        if (currentState.currentExerciseIndex <
            workoutDay.exercises.length - 1) {
          emit(currentState.copyWith(
            currentExerciseIndex: currentState.currentExerciseIndex + 1,
            currentSetIndex: 0,
            remainingTime: workoutDay
                .exercises[currentState.currentExerciseIndex + 1].restSeconds,
            isRunning: false,
          ));
        } else {
          emit(WorkoutCompleted());
        }
      }
    }
  }

  void _onSkipExercise(SkipExercise event, Emitter<WorkoutState> emit) {
    if (state is WorkoutInProgress) {
      final currentState = state as WorkoutInProgress;
      if (currentState.currentExerciseIndex < workoutDay.exercises.length - 1) {
        emit(currentState.copyWith(
          currentExerciseIndex: currentState.currentExerciseIndex + 1,
          currentSetIndex: 0,
          remainingTime: workoutDay
              .exercises[currentState.currentExerciseIndex + 1].restSeconds,
          isRunning: false,
        ));
      } else {
        emit(WorkoutCompleted());
      }
    }
  }

  void _onEndWorkout(EndWorkout event, Emitter<WorkoutState> emit) {
    emit(WorkoutCompleted());
  }

  void _onUpdateWeight(UpdateWeight event, Emitter<WorkoutState> emit) {
    if (state is WorkoutInProgress) {
      final currentState = state as WorkoutInProgress;
      emit(currentState.copyWith(weightInput: event.weight));
    }
  }

  void _startTimer(WorkoutInProgress currentState, Emitter<WorkoutState> emit) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentState.isRunning && currentState.remainingTime > 0) {
        emit(currentState.copyWith(
            remainingTime: currentState.remainingTime - 1));
      } else {
        timer.cancel();
        add(CompleteSet());
      }
    });
  }
}
