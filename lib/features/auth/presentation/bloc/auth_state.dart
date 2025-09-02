part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  final UserModel? user;
  const AuthState(this.user);

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial(super.user);
}

final class AuthLoading extends AuthState {
  const AuthLoading(super.user);
}

final class VerificationCodeSent extends AuthState {
  final String phone;
  final String password;
  const VerificationCodeSent(super.user,
      {required this.password, required this.phone});
  @override
  List<Object> get props => [phone, password];
}

final class VerificationCodeVerified extends AuthState {
  final String phone;
  final String password;
  const VerificationCodeVerified(super.user,
      {required this.phone, required this.password});
  @override
  List<Object> get props => [phone, password];
}

final class VerifyingVerificationCode extends AuthState {
  const VerifyingVerificationCode(super.user);
}

final class Authenticated extends AuthState {
  const Authenticated(
    super.user,
  );

  @override
  List<Object> get props => [user!];
}

final class ForgotPasswordRequestSuccess extends AuthState {
  final String phoneNumber;

  const ForgotPasswordRequestSuccess(super.user, {required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

final class ResendCodeRequestSuccess extends AuthState {
  final String phoneNumber;

  const ResendCodeRequestSuccess(super.user, {required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

final class Signedup extends AuthState {
  const Signedup(super.user);
}

final class ResetPasswordRequestSuccess extends AuthState {
  const ResetPasswordRequestSuccess(super.user);
}

final class RequestingForgotPassword extends AuthState {
  const RequestingForgotPassword(super.user);
}

final class RequestingResendCode extends AuthState {
  const RequestingResendCode(super.user);
}

final class RequestingResetPassword extends AuthState {
  const RequestingResetPassword(super.user);
}

final class ChangePasswordRequestSuccess extends AuthState {
  const ChangePasswordRequestSuccess(super.user);
}

final class RequestingChangePassword extends AuthState {
  const RequestingChangePassword(super.user);
}

final class Unauthenticated extends AuthState {
  final String? message;

  const Unauthenticated(super.user, {this.message});

  @override
  List<Object> get props => [message ?? ''];
}

final class AuthError extends AuthState {
  final String error;

  const AuthError(super.user, this.error);

  @override
  List<Object> get props => [error];
}

final class UpdatingProfileInfo extends AuthState {
  const UpdatingProfileInfo(
    super.user,
  );
}

final class ProfileInfoUpdated extends AuthState {
  final UserProfileModel userProfileModel;
  const ProfileInfoUpdated(
    this.userProfileModel,
  ) : super(null);

  @override
  List<Object> get props => [userProfileModel];
}

final class GetProfileInfoSuccess extends AuthState {
  final UserProfileModel userProfileModel;
  const GetProfileInfoSuccess(
    this.userProfileModel,
  ) : super(null);

  @override
  List<Object> get props => [userProfileModel];
}
