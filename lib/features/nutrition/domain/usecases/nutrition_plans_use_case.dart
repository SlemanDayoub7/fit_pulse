import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';
import 'package:gym_app/features/nutrition/domain/repos/nutrition_plans_repo.dart';

class GetNutritionPlansUseCase {
  final NutritionPlansRepository repository;

  GetNutritionPlansUseCase({required this.repository});

  Future<ApiResult<List<NutritionPlan>>> call() async {
    return await repository.getNutritionPlans();
  }
}
