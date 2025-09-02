import 'package:equatable/equatable.dart';

abstract class NutritionPlansEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event to load list of nutrition plans
class LoadNutritionPlans extends NutritionPlansEvent {}

// (Optional) Event to load a single nutrition plan by id
class LoadNutritionPlan extends NutritionPlansEvent {
  final int id;

  LoadNutritionPlan(this.id);

  @override
  List<Object?> get props => [id];
}
