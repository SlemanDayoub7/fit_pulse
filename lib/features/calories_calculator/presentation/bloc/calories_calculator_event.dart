import 'package:equatable/equatable.dart';
import 'package:gym_app/features/calories_calculator/domain/entites/gender.dart';

import '../../domain/usecases/calculate_calories_usecase.dart';

abstract class CaloriesCalculatorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenderChanged extends CaloriesCalculatorEvent {
  final Gender gender;
  GenderChanged(this.gender);

  @override
  List<Object?> get props => [gender];
}

class ActivityLevelChanged extends CaloriesCalculatorEvent {
  final ActivityLevel activityLevel;
  ActivityLevelChanged(this.activityLevel);

  @override
  List<Object?> get props => [activityLevel];
}

class CalculateCaloriesEvent extends CaloriesCalculatorEvent {
  final int age;
  final double weight;
  final double height;

  CalculateCaloriesEvent({
    required this.age,
    required this.weight,
    required this.height,
  });

  @override
  List<Object?> get props => [age, weight, height];
}
