import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/params/global_params.dart';

import 'package:gym_app/core/params/login_params.dart';
import 'package:gym_app/core/params/signup_params.dart';
import 'package:gym_app/core/params/update_profile_params.dart';

import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';

abstract class AuthRepo {
  Future<ApiResult<UserProfileModel>> updateProfile(
      UpdateProfileParams updateProfileParams);
  Future<ApiResult<UserModel>> login(LoginParams loginParams);
  Future<ApiResult<UserModel>> signup(SignupParams signUpParams);
  Future<ApiResult<UserProfileModel>> getProfile(GlobalParams getProfileParams);
}
