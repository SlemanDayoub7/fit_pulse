import 'package:gym_app/core/networking/api_result.dart';

import 'package:gym_app/features/workouts/data/models/response_models/sport.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';

abstract class WorkoutPlansRepository {
  Future<ApiResult<List<WorkoutPlan>>> getWorkoutPlans();
  Future<ApiResult<List<Sport>>> getSports();
}
