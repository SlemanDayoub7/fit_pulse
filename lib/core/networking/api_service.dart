import 'package:dio/dio.dart';
import 'package:gym_app/core/networking/api_constants.dart';
import 'package:gym_app/features/auth/data/models/request_models/login_request_body.dart';

import 'package:gym_app/features/auth/data/models/request_models/signup_request_body.dart';
import 'package:gym_app/features/auth/data/models/request_models/update_profile_request_body.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';

import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:gym_app/features/nutrition/data/models/response_models/nutrition_plan.dart';
import 'package:gym_app/features/workouts/data/models/response_models/sport.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';

import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<UserModel> login(@Body() LoginRequestBody loginRequestBody);
  @POST(ApiConstants.signup)
  Future<UserModel> signup(@Body() SignupRequestBody signupRequestBody);
  @PATCH(ApiConstants.profile)
  Future<UserProfileModel> updateProfile(
      @Body() UpdateProfileRequestBody updateProfileRequestBody);

  @GET(ApiConstants.profile)
  Future<List<UserProfileModel>> getProfile();
  @GET(ApiConstants.sports)
  Future<List<Sport>> getSports();
  @GET(ApiConstants.plans)
  Future<List<WorkoutPlan>> getWorkoutPlans();

  @GET(ApiConstants.nutritionPlans)
  Future<List<NutritionPlan>> getNutritionPlans();
}
