import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/features/workouts/data/datasource/workout_plans_remote_datasource.dart';
import 'package:gym_app/features/workouts/data/models/response_models/sport.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';
import 'package:gym_app/features/workouts/domain/repos/workout_plans_repo.dart';

class WorkoutPlansRepositoryImpl implements WorkoutPlansRepository {
  final WorkoutPlansRemoteDataSource workoutPlanRemoteDataSource;

  WorkoutPlansRepositoryImpl({required this.workoutPlanRemoteDataSource});

  @override
  Future<ApiResult<List<WorkoutPlan>>> getWorkoutPlans() {
    return workoutPlanRemoteDataSource.fetchWorkoutPlans();
  }

  @override
  Future<ApiResult<List<Sport>>> getSports() {
    return workoutPlanRemoteDataSource.fetchSports();
  }
}
