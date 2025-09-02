import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/params/login_params.dart';
import 'package:gym_app/core/usecases/usecase.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repo.dart';

class LoginUsecase extends UseCase<UserModel, LoginParams> {
  final AuthRepo repository;

  LoginUsecase({required this.repository});

  @override
  Future<ApiResult<UserModel>> call(LoginParams loginParams) async {
    return await repository.login(loginParams);
  }
}
