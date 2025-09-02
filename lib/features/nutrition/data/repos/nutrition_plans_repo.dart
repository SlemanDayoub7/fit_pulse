import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/features/nutrition/data/datasource/nutrition_plans_remote_datasource.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';
import 'package:gym_app/features/nutrition/domain/repos/nutrition_plans_repo.dart';

class NutritionPlansRepositoryImpl implements NutritionPlansRepository {
  final NutritionPlansRemoteDataSource nutritionPlansRemoteDatasource;

  NutritionPlansRepositoryImpl({required this.nutritionPlansRemoteDatasource});

  @override
  Future<ApiResult<List<NutritionPlan>>> getNutritionPlans() {
    return nutritionPlansRemoteDatasource.fetchNutritionPlans();
  }

  // @override
  // Future<ApiResult<List<Sport>>> getSports() {
  //   return workoutPlanRemoteDataSource.fetchSports();
  // }
}
