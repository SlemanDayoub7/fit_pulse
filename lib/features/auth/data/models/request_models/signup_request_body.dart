import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gym_app/core/constants/base_request_model.dart';
part 'signup_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody extends BaseRequestModel {
  final String email;
  final String password;
  SignupRequestBody({required this.email, required this.password});
  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
