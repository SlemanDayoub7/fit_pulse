import 'package:gym_app/core/networking/api_result.dart';

import 'package:gym_app/core/params/signup_params.dart';
import 'package:gym_app/core/usecases/usecase.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repo.dart';

class SignupUsecase extends UseCase<UserModel, SignupParams> {
  final AuthRepo repository;

  SignupUsecase({required this.repository});

  @override
  Future<ApiResult<UserModel>> call(SignupParams signUpParams) async {
    return await repository.signup(signUpParams);
  }
}
