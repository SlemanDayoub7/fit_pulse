import 'package:gym_app/features/auth/data/models/response_models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse extends UserModel {
  String? token;
  SignupResponse({this.token});
  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);
}
