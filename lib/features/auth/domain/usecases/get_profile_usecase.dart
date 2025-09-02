import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/params/global_params.dart';
import 'package:gym_app/core/params/update_profile_params.dart';
import 'package:gym_app/core/usecases/usecase.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repo.dart';

class GetProfileUsecase extends UseCase<UserProfileModel, GlobalParams> {
  final AuthRepo repository;

  GetProfileUsecase({required this.repository});

  @override
  Future<ApiResult<UserProfileModel>> call(GlobalParams params) async {
    return await repository.getProfile(params);
  }
}
