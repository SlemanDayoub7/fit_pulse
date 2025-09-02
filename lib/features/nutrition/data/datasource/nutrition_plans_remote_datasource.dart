import 'package:gym_app/core/networking/api_error_handler.dart';
import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/networking/api_service.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';

abstract class NutritionPlansRemoteDataSource {
  Future<ApiResult<List<NutritionPlan>>> fetchNutritionPlans();
  // Future<ApiResult<List<Sport>>> fetchSports();
}

class NutritionPlansRemoteDataSourceImpl
    implements NutritionPlansRemoteDataSource {
  final ApiService apiService;

  NutritionPlansRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ApiResult<List<NutritionPlan>>> fetchNutritionPlans() async {
    try {
      final response = await apiService.getNutritionPlans();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  // @override
  // Future<ApiResult<List<Sport>>> fetchSports() async {
  //   try {
  //     final response = await apiService.getSports();
  //     return ApiResult.success(response);
  //   } catch (error) {
  //     return ApiResult.failure(ErrorHandler.handle(error));
  //   }
  // }
}
