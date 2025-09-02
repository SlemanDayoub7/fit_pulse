import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gym_app/core/constants/shared_pref_keys.dart';
import 'package:gym_app/core/helpers/shared_pref_helper.dart';
import 'package:gym_app/core/networking/dio_factory.dart';
import 'package:gym_app/core/params/global_params.dart';
import 'package:gym_app/core/params/login_params.dart';
import 'package:gym_app/core/params/signup_params.dart';
import 'package:gym_app/core/params/update_profile_params.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';
import 'package:gym_app/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:gym_app/features/auth/domain/usecases/update_profile_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupUsecase signUpUseCase;
  final GetProfileUsecase getProfileUsecase;
  final LoginUsecase loginUseCase;
  final UpdateProfileUsecase updateProfileUsecase;
  AuthBloc({
    required this.getProfileUsecase,
    required this.updateProfileUsecase,
    required this.signUpUseCase,
    required this.loginUseCase,
  }) : super(AuthInitial(null)) {
    on<SignedIn>(_onSignedUp);
    on<LoginEvent>(_onLogin);
    on<UpdateProfileInfoEvent>(_onUpdateProfileInfo);
    on<GetProfileInfo>(_onGetProfileInfo);
  }

  Future<void> _onSignedUp(
    SignedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(state.user));

    var response = await signUpUseCase.call(SignupParams(
      email: event.email,
      password: event.password,
    ));
    print('object');
    print(response);
    response.when(success: (signupResponse) {
      print('odbject');
      emit(Signedup(signupResponse));
      print('ssssssssssssssssss');
    }, failure: (e) {
      print(e.apiErrorModel.message);
      emit(AuthError(
          state.user, e.apiErrorModel.message ?? 'An error occurred'));
      emit(Unauthenticated(state.user,
          message: e.apiErrorModel.message ?? 'An error occurred'));
    });
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading(state.user));

    var response = await loginUseCase.call(LoginParams(
      email: event.email,
      password: event.password,
    ));

    response.when(success: (loginResponse) async {
      emit(Authenticated(loginResponse));
      await saveUserToken(loginResponse.access ?? '');
      print('sssss');
    }, failure: (e) {
      emit(AuthError(
          state.user, e.apiErrorModel.message ?? 'An error occurred'));
      emit(Unauthenticated(state.user,
          message: e.apiErrorModel.message ?? 'An error occurred'));
    });
  }

  Future<void> _onGetProfileInfo(
    GetProfileInfo event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading(state.user));

    final response = await getProfileUsecase.call(GlobalParams());
    print(response);
    response.when(success: (updatedUserProfile) {
      emit(GetProfileInfoSuccess(updatedUserProfile));
    }, failure: (e) {
      emit(AuthError(
          state.user, e.apiErrorModel.message ?? 'Failed to update profile'));
    });
  }

  Future<void> _onUpdateProfileInfo(
    UpdateProfileInfoEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(UpdatingProfileInfo(state.user));
    final params = UpdateProfileParams(
      firstName: event.firstName,
      lastName: event.lastName,
      weight: event.weight,
      goalWeight: event.goalWeight,
      height: event.height,
    );

    final response = await updateProfileUsecase.call(params);

    response.when(success: (updatedUserProfile) {
      emit(ProfileInfoUpdated(updatedUserProfile));
    }, failure: (e) {
      emit(AuthError(
          state.user, e.apiErrorModel.message ?? 'Failed to update profile'));
    });
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
