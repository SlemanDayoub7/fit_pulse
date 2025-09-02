import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';
import 'package:gym_app/features/workouts/domain/repos/workout_plans_repo.dart';

class GetWorkoutPlansUseCase {
  final WorkoutPlansRepository repository;

  GetWorkoutPlansUseCase({required this.repository});

  Future<ApiResult<List<WorkoutPlan>>> call() async {
    return await repository.getWorkoutPlans();
  }
}
