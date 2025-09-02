import 'package:dio/dio.dart';
import 'package:gym_app/core/constants/base_request_model.dart';
import 'package:gym_app/core/networking/api_error_model.dart';
import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/networking/api_service.dart';
import 'package:gym_app/core/networking/result.dart';
import 'package:gym_app/core/params/global_params.dart';
import 'package:gym_app/core/params/login_params.dart';
import 'package:gym_app/core/params/signup_params.dart';
import 'package:gym_app/core/params/update_profile_params.dart';
import 'package:gym_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gym_app/features/auth/data/models/request_models/update_profile_request_body.dart';
import 'package:gym_app/features/auth/data/models/response_models/signup_response.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repo.dart';

import '../models/request_models/login_request_body.dart';
import '../models/request_models/signup_request_body.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepoImpl({required this.authRemoteDataSource});

  @override
  Future<ApiResult<UserModel>> login(LoginParams params) {
    return authRemoteDataSource.login(
        loginRequestBody:
            LoginRequestBody(email: params.email, password: params.password));
  }

  @override
  Future<ApiResult<UserModel>> signup(SignupParams params) {
    return authRemoteDataSource.signup(
        signupRequestBody:
            SignupRequestBody(email: params.email, password: params.password));
  }

  @override
  Future<ApiResult<UserProfileModel>> updateProfile(
      UpdateProfileParams params) {
    return authRemoteDataSource.updateProfile(
        updateProfileRequestBody: UpdateProfileRequestBody(
      firstName: params.firstName,
      lastName: params.lastName,
      weight: params.weight,
      goalWeight: params.goalWeight,
      height: params.height,
    ));
  }

  @override
  Future<ApiResult<UserProfileModel>> getProfile(GlobalParams params) {
    return authRemoteDataSource.getProfile();
  }
}
