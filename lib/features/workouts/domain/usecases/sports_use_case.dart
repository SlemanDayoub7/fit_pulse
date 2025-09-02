import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/features/workouts/data/models/response_models/sport.dart';
import 'package:gym_app/features/workouts/domain/repos/workout_plans_repo.dart';

class GetSportsUseCase {
  final WorkoutPlansRepository repository;

  GetSportsUseCase({required this.repository});

  Future<ApiResult<List<Sport>>> call() async {
    return await repository.getSports();
  }
}
