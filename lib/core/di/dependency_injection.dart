import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:gym_app/core/networking/api_service.dart';
import 'package:gym_app/core/networking/dio_factory.dart';
import 'package:gym_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:gym_app/features/auth/data/repos/auth_repo.dart';
import 'package:gym_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:gym_app/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:gym_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:gym_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:gym_app/features/auth/domain/usecases/update_profile_usecase.dart';

import 'package:gym_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gym_app/features/nutrition/data/datasource/nutrition_plans_remote_datasource.dart';
import 'package:gym_app/features/nutrition/data/repos/nutrition_plans_repo.dart';
import 'package:gym_app/features/nutrition/domain/repos/nutrition_plans_repo.dart';
import 'package:gym_app/features/nutrition/domain/usecases/nutrition_plans_use_case.dart';
import 'package:gym_app/features/nutrition/presentation/bloc/nutrition_plans_bloc.dart';
import 'package:gym_app/features/training/presentation/bloc/training_bloc.dart';
import 'package:gym_app/features/workouts/data/datasource/workout_plans_remote_datasource.dart';
import 'package:gym_app/features/workouts/data/repos/workout_plan_repo.dart';
import 'package:gym_app/features/workouts/domain/repos/workout_plans_repo.dart';
import 'package:gym_app/features/workouts/domain/usecases/sports_use_case.dart';
import 'package:gym_app/features/workouts/domain/usecases/workout_plans_use_case.dart';
import 'package:gym_app/features/workouts/presentation/bloc/sports_bloc/sports_bloc.dart';
import 'package:gym_app/features/workouts/presentation/bloc/workout_plans_bloc.dart';

var sl = GetIt.instance;

Future<void> init() async {
  Dio dio = DioFactory.getDio();
  sl.registerLazySingleton<ApiService>(() => ApiService(dio));

  initFeatures();
}

Future<void> initCore() async {
  // Dio & ApiService
}

initFeatures() {
  initAuthFeature();
  initWorkoutPlansFeature();
  initSportsFeature();
  initNutritionPlansFeature();
}

void initSportsFeature() {
  sl.registerFactory(() => SportsBloc(
        getSportsUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetSportsUseCase(repository: sl()));
}

void initNutritionPlansFeature() {
  sl.registerLazySingleton<NutritionPlansRepository>(
      () => NutritionPlansRepositoryImpl(nutritionPlansRemoteDatasource: sl()));
  sl.registerLazySingleton<NutritionPlansRemoteDataSource>(
      () => NutritionPlansRemoteDataSourceImpl(apiService: sl()));

  sl.registerFactory(() => NutritionPlansBloc(
        getNutritionPlansUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetNutritionPlansUseCase(repository: sl()));
}

void initWorkoutPlansFeature() {
  sl.registerLazySingleton<WorkoutPlansRepository>(
      () => WorkoutPlansRepositoryImpl(workoutPlanRemoteDataSource: sl()));
  sl.registerLazySingleton<WorkoutPlansRemoteDataSource>(
      () => WorkoutPlansRemoteDataSourceImpl(apiService: sl()));

  sl.registerFactory(() => WorkoutPlansBloc(
        getWorkoutPlansUseCase: sl(),
      ));

  sl.registerLazySingleton(() => GetWorkoutPlansUseCase(repository: sl()));
}

void initAuthFeature() {
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(apiService: sl()));

  sl.registerFactory(() => AuthBloc(
        signUpUseCase: sl(),
        loginUseCase: sl(),
        updateProfileUsecase: sl(),
        getProfileUsecase: sl(),
      ));

  //authentication usecases
  sl.registerLazySingleton(() => GetProfileUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateProfileUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupUsecase(repository: sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
}
