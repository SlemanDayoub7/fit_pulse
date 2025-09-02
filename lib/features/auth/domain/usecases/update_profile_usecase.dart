import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/params/update_profile_params.dart';
import 'package:gym_app/core/usecases/usecase.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repo.dart';

class UpdateProfileUsecase
    extends UseCase<UserProfileModel, UpdateProfileParams> {
  final AuthRepo repository;

  UpdateProfileUsecase({required this.repository});

  @override
  Future<ApiResult<UserProfileModel>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(params);
  }
}
