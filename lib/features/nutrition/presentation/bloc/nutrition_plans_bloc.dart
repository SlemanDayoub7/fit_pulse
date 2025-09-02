import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/features/nutrition/domain/usecases/nutrition_plans_use_case.dart';
import 'nutrition_plans_event.dart';
import 'nutrition_plans_state.dart';

class NutritionPlansBloc
    extends Bloc<NutritionPlansEvent, NutritionPlansState> {
  final GetNutritionPlansUseCase getNutritionPlansUseCase;

  NutritionPlansBloc({required this.getNutritionPlansUseCase})
      : super(NutritionPlansInitial()) {
    on<LoadNutritionPlans>((event, emit) async {
      emit(NutritionPlansLoading());
      final response = await getNutritionPlansUseCase.call();
      response.when(
        success: (nutritionPlansResponse) {
          emit(NutritionPlansLoaded(nutritionPlansResponse));
        },
        failure: (e) {
          emit(NutritionPlansError(
              e.apiErrorModel.message ?? 'An error occurred'));
        },
      );
    });

    // on<LoadNutritionPlan>((event, emit) async {
    //   emit(NutritionPlansLoading());
    //   // Implement fetching single nutrition plan by id if needed
    //   // Example:
    //   // final response = await getNutritionPlanByIdUseCase.call(event.id);
    //   // response.when(...)
    // });
  }
}
