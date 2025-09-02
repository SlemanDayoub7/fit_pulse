import 'package:equatable/equatable.dart';
import 'package:gym_app/features/calories_calculator/domain/entites/gender.dart';

import '../../domain/usecases/calculate_calories_usecase.dart';

class CaloriesCalculatorState extends Equatable {
  final Gender gender;
  final ActivityLevel activityLevel;
  final double? calories;
  final bool isLoading;
  final String? error;

  const CaloriesCalculatorState({
    required this.gender,
    required this.activityLevel,
    this.calories,
    this.isLoading = false,
    this.error,
  });

  factory CaloriesCalculatorState.initial() {
    return CaloriesCalculatorState(
      gender: Gender.male,
      activityLevel: ActivityLevel.sedentary,
      calories: null,
      isLoading: false,
      error: null,
    );
  }

  CaloriesCalculatorState copyWith({
    Gender? gender,
    ActivityLevel? activityLevel,
    double? calories,
    bool? isLoading,
    String? error,
  }) {
    return CaloriesCalculatorState(
      gender: gender ?? this.gender,
      activityLevel: activityLevel ?? this.activityLevel,
      calories: calories,
      isLoading: isLoading ?? false,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [gender, activityLevel, calories, isLoading, error];
}
