import 'package:gym_app/core/constants/base_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel extends BaseRequestModel {
  final int? id;

  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;

  final String? user;

  final double? weight;

  @JsonKey(name: 'goal_weight')
  final double? goalWeight;

  final double? height;

  @JsonKey(name: 'birth_date')
  final String? birthDate;

  @JsonKey(name: 'fitness_level')
  final String? fitnessLevel;

  @JsonKey(name: 'fitness_goal')
  final String? fitnessGoal;

  final String? certification;

  @JsonKey(name: 'years_of_experience')
  final int? yearsOfExperience;

  UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.user,
    this.weight,
    this.goalWeight,
    this.height,
    this.birthDate,
    this.fitnessLevel,
    this.fitnessGoal,
    this.certification,
    this.yearsOfExperience,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);
}
