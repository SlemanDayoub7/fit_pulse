import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/training/domain/models/exercise_training.dart';
import 'package:gym_app/features/training/presentation/bloc/training_event.dart';
import 'package:gym_app/features/training/presentation/bloc/training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final List<ExerciseTraining> _exercises;
  int _currentExerciseIndex = 0;
  int _currentSet = 1;
  int _exerciseTimeElapsed = 0;
  int _totalTimeElapsed = 0;
  int _restTimeLeft = 0;
  int _repsDone = 0;
  bool _isExerciseRunning = false;
  bool _isOnRest = false;

  Timer? _timer;
  Timer? _restTimer;
  final int restDurationSeconds = 30;

  List<ExerciseTraining> get exercises => _exercises;

  TrainingBloc(this._exercises) : super(TrainingInitial()) {
    on<StartExerciseTimer>(_onStartExerciseTimer);
    on<PauseExerciseTimer>(_onPauseExerciseTimer);
    on<Tick>(_onTick);
    on<FinishSet>(_onFinishSet);
    on<SkipExercise>(_onSkipExercise);
    on<TickRest>(_onTickRest);
    on<IncrementReps>(_onIncrementReps);
    on<DecrementReps>(_onDecrementReps);
    on<SkipRest>(_onSkipRest); // NEW
  }

  void _onStartExerciseTimer(
      StartExerciseTimer event, Emitter<TrainingState> emit) {
    _isExerciseRunning = true;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => add(Tick()));
    _emitState(emit);
  }

  void _onPauseExerciseTimer(
      PauseExerciseTimer event, Emitter<TrainingState> emit) {
    _isExerciseRunning = false;
    _timer?.cancel();
    _emitState(emit);
  }

  void _onTick(Tick event, Emitter<TrainingState> emit) {
    _exerciseTimeElapsed++;
    _totalTimeElapsed++;
    _emitState(emit);
  }

  void _onFinishSet(FinishSet event, Emitter<TrainingState> emit) {
    _isExerciseRunning = false;
    _timer?.cancel();
    _repsDone = 0;

    _isOnRest = true;
    _restTimeLeft = restDurationSeconds;
    _restTimer?.cancel();
    _restTimer = Timer.periodic(Duration(seconds: 1), (_) => add(TickRest()));
    _emitState(emit);
  }

  void _onTickRest(TickRest event, Emitter<TrainingState> emit) {
    _restTimeLeft--;
    _totalTimeElapsed++;

    if (_restTimeLeft <= 0) {
      _isOnRest = false;
      _restTimer?.cancel();
      _exerciseTimeElapsed = 0;
      _repsDone = 0;

      final currentExercise = _exercises[_currentExerciseIndex];
      if (_currentSet < (currentExercise.sets ?? 1)) {
        _currentSet++;
      } else {
        _currentSet = 1;
        _currentExerciseIndex++;
        if (_currentExerciseIndex >= _exercises.length) {
          emit(TrainingCompleted());
          return;
        }
      }
    }

    _emitState(emit);
  }

  void _onSkipRest(SkipRest event, Emitter<TrainingState> emit) {
    _restTimer?.cancel();
    _isOnRest = false;
    _exerciseTimeElapsed = 0;
    _repsDone = 0;

    final currentExercise = _exercises[_currentExerciseIndex];
    if (_currentSet < (currentExercise.sets ?? 1)) {
      _currentSet++;
    } else {
      _currentSet = 1;
      _currentExerciseIndex++;
      if (_currentExerciseIndex >= _exercises.length) {
        emit(TrainingCompleted());
        return;
      }
    }

    _emitState(emit);
  }

  void _onSkipExercise(SkipExercise event, Emitter<TrainingState> emit) {
    _timer?.cancel();
    _restTimer?.cancel();
    _isExerciseRunning = false;
    _isOnRest = false;
    _exerciseTimeElapsed = 0;
    _repsDone = 0;
    _currentSet = 1;
    _currentExerciseIndex++;
    if (_currentExerciseIndex >= _exercises.length) {
      emit(TrainingCompleted());
    } else {
      _emitState(emit);
    }
  }

  void _onIncrementReps(IncrementReps event, Emitter<TrainingState> emit) {
    final max = _exercises[_currentExerciseIndex].reps ?? 999;
    if (_repsDone < max) {
      _repsDone++;
      _emitState(emit);
    }
  }

  void _onDecrementReps(DecrementReps event, Emitter<TrainingState> emit) {
    if (_repsDone > 0) {
      _repsDone--;
      _emitState(emit);
    }
  }

  void _emitState(Emitter<TrainingState> emit) {
    final exercise = _exercises[_currentExerciseIndex];
    final exerciseTime = exercise.time ?? 60;
    final sets = exercise.sets ?? 1;
    emit(TrainingInProgress(
      currentExerciseIndex: _currentExerciseIndex,
      currentSet: _currentSet,
      totalSets: sets,
      exerciseTimeElapsed: _exerciseTimeElapsed,
      exerciseTimeRemaining: exerciseTime - _exerciseTimeElapsed,
      totalTimeElapsed: _totalTimeElapsed,
      isExerciseRunning: _isExerciseRunning,
      isOnRest: _isOnRest,
      restTimeLeft: _restTimeLeft,
      repsDone: _repsDone,
    ));
  }
}
