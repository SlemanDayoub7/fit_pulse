import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gym_app/core/constants/app_constants.dart';
import 'package:gym_app/core/constants/base_request_model.dart';
import 'package:gym_app/core/networking/api_error_handler.dart';
import 'package:gym_app/core/networking/api_general_model.dart';
import 'package:gym_app/core/networking/api_result.dart';
import 'package:gym_app/core/networking/api_service.dart';
import 'package:gym_app/features/auth/data/models/request_models/login_request_body.dart';
import 'package:gym_app/features/auth/data/models/request_models/signup_request_body.dart';
import 'package:gym_app/features/auth/data/models/request_models/update_profile_request_body.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<UserProfileModel>> updateProfile(
      {required BaseRequestModel updateProfileRequestBody});
  Future<ApiResult<UserProfileModel>> getProfile();

  Future<ApiResult<UserModel>> signup(
      {required BaseRequestModel signupRequestBody});
  Future<ApiResult<UserModel>> login(
      {required BaseRequestModel loginRequestBody});
  // Future<ApiResult<bool>> verifyCode(
  //     {required BaseRequestModel verifyCodeRequestModel});
  // Future<ApiResult<bool>> forgotPassword(
  //     {required BaseRequestModel forgotPasswordRequestModel});

  // Future<ApiResult<bool>> resendCode(
  //     {required BaseRequestModel resendCodeRequestModel});
  // Future<ApiResult<bool>> resetPassword(
  //     {required BaseRequestModel resetPasswordRequestModel});
  // Future<ApiResult<bool>> changePassword(
  //     {required BaseRequestModel changePasswordRequestModel});
  // Future<ApiResult<UserModel>> getProfileInfo();
  // Future<ApiResult<bool>> updateProfileInfo(
  //     {required BaseRequestModel updateProfileInfoRequestModel});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<ApiResult<UserModel>> signup(
      {required BaseRequestModel signupRequestBody}) async {
    try {
      final response =
          await apiService.signup(signupRequestBody as SignupRequestBody);
      // print(response);
      return ApiResult.success(response);
    } catch (error) {
      // print(error);
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<UserModel>> login(
      {required BaseRequestModel loginRequestBody}) async {
    try {
      final response =
          await apiService.login(loginRequestBody as LoginRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<UserProfileModel>> updateProfile(
      {required BaseRequestModel updateProfileRequestBody}) async {
    try {
      final response = await apiService
          .updateProfile(updateProfileRequestBody as UpdateProfileRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  @override
  Future<ApiResult<UserProfileModel>> getProfile() async {
    try {
      final response = await apiService.getProfile();

      return ApiResult.success(response[0]);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
