import 'package:gym_app/core/constants/base_request_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_profile_request_body.g.dart';

@JsonSerializable()
class UpdateProfileRequestBody extends BaseRequestModel {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;

  final String weight;

  @JsonKey(name: 'goal_weight')
  final String goalWeight;

  final int height;
  UpdateProfileRequestBody({
    required this.firstName,
    required this.lastName,
    required this.weight,
    required this.goalWeight,
    required this.height,
  });
  Map<String, dynamic> toJson() => _$UpdateProfileRequestBodyToJson(this);
  factory UpdateProfileRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestBodyFromJson(json);
}
