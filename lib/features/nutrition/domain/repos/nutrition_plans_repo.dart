import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';

abstract class NutritionPlansRepository {
  Future<ApiResult<List<NutritionPlan>>> getNutritionPlans();
  // Future<ApiResult<List<Sport>>> getSports();
}
