import 'package:equatable/equatable.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';

abstract class NutritionPlansState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NutritionPlansInitial extends NutritionPlansState {}

class NutritionPlansLoading extends NutritionPlansState {}

class NutritionPlansLoaded extends NutritionPlansState {
  final List<NutritionPlan> nutritionPlans;

  NutritionPlansLoaded(this.nutritionPlans);

  @override
  List<Object?> get props => [nutritionPlans];
}

class NutritionPlanLoaded extends NutritionPlansState {
  final NutritionPlan nutritionPlan;

  NutritionPlanLoaded(this.nutritionPlan);

  @override
  List<Object?> get props => [nutritionPlan];
}

class NutritionPlansError extends NutritionPlansState {
  final String message;

  NutritionPlansError(this.message);

  @override
  List<Object?> get props => [message];
}
