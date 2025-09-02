part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthCheckRequested extends AuthEvent {}

final class SignedIn extends AuthEvent {
  final String email;
  final String password;

  const SignedIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class UpdateProfileInfoEvent extends AuthEvent {
  final String firstName;
  final String lastName;

  final String weight;
  final String goalWeight;
  final int height;
  const UpdateProfileInfoEvent({
    required this.firstName,
    required this.lastName,
    required this.weight,
    required this.goalWeight,
    required this.height,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        weight,
        goalWeight,
        height,
      ];
}

final class SignedUp extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String nationalNumber;

  const SignedUp(
      {required this.email,
      required this.password,
      required this.fullName,
      required this.nationalNumber,
      required this.phoneNumber});

  @override
  List<Object> get props =>
      [email, password, fullName, nationalNumber, phoneNumber];
}

final class VerifyVerificationCode extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String code;

  const VerifyVerificationCode(
      {required this.code, required this.password, required this.phoneNumber});

  @override
  List<Object> get props => [password, phoneNumber];
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String? deviceId;
  final String? fcmToken;

  const LoginEvent(
      {required this.password,
      required this.email,
      this.deviceId,
      this.fcmToken});

  @override
  List<Object> get props => [password, email, deviceId!, fcmToken!];
}

final class Logout extends AuthEvent {}

final class GetLoggedUser extends AuthEvent {}

final class SignedOut extends AuthEvent {}

final class PasswordResetRequested extends AuthEvent {
  final String email;

  const PasswordResetRequested(this.email);

  @override
  List<Object> get props => [email];
}

final class ForgotPasswordRequested extends AuthEvent {
  final String phoneNumber;

  const ForgotPasswordRequested(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

final class ResendCodeRequested extends AuthEvent {
  final String phoneNumber;

  const ResendCodeRequested(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

final class ResetPasswordRequested extends AuthEvent {
  final String phoneNumber, code, password;

  const ResetPasswordRequested(
      {required this.phoneNumber, required this.code, required this.password});

  @override
  List<Object> get props => [phoneNumber, code, password];
}

final class ChangePasswordRequested extends AuthEvent {
  final String userId, currentPassword, newPassword;

  const ChangePasswordRequested(
      {required this.userId,
      required this.currentPassword,
      required this.newPassword});

  @override
  List<Object> get props => [userId, currentPassword, newPassword];
}

final class GetProfileInfo extends AuthEvent {
  const GetProfileInfo();

  @override
  List<Object> get props => [];
}
