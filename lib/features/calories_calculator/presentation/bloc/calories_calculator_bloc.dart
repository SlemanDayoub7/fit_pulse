import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/calculate_calories_usecase.dart';
import 'calories_calculator_event.dart';
import 'calories_calculator_state.dart';

class CaloriesCalculatorBloc
    extends Bloc<CaloriesCalculatorEvent, CaloriesCalculatorState> {
  final CalculateCaloriesUseCase _calculateCaloriesUseCase;

  CaloriesCalculatorBloc()
      : _calculateCaloriesUseCase = CalculateCaloriesUseCase(),
        super(CaloriesCalculatorState.initial()) {
    on<GenderChanged>(_onGenderChanged);
    on<ActivityLevelChanged>(_onActivityLevelChanged);
    on<CalculateCaloriesEvent>(_onCalculateCalories);
  }

  void _onGenderChanged(
      GenderChanged event, Emitter<CaloriesCalculatorState> emit) {
    emit(state.copyWith(gender: event.gender, calories: null, error: null));
  }

  void _onActivityLevelChanged(
      ActivityLevelChanged event, Emitter<CaloriesCalculatorState> emit) {
    emit(state.copyWith(
        activityLevel: event.activityLevel, calories: null, error: null));
  }

  void _onCalculateCalories(CalculateCaloriesEvent event,
      Emitter<CaloriesCalculatorState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final calories = _calculateCaloriesUseCase.execute(
        gender: state.gender,
        age: event.age,
        weight: event.weight,
        height: event.height,
        activityLevel: state.activityLevel,
      );
      emit(state.copyWith(calories: calories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: 'Calculation failed', isLoading: false));
    }
  }
}
