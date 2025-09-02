import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.password, required this.email});

  @override
  List<Object?> get props => [email, password];
}
