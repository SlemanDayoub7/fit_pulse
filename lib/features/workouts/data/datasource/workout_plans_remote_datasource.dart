import 'package:gym_app/core/networking/api_error_handler.dart';
import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/networking/api_service.dart';
import 'package:gym_app/features/workouts/data/models/response_models/sport.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';

abstract class WorkoutPlansRemoteDataSource {
  Future<ApiResult<List<WorkoutPlan>>> fetchWorkoutPlans();
  Future<ApiResult<List<Sport>>> fetchSports();
}

class WorkoutPlansRemoteDataSourceImpl implements WorkoutPlansRemoteDataSource {
  final ApiService apiService;

  WorkoutPlansRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ApiResult<List<WorkoutPlan>>> fetchWorkoutPlans() async {
    try {
      final response = await apiService.getWorkoutPlans();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<List<Sport>>> fetchSports() async {
    try {
      final response = await apiService.getSports();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
