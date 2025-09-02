// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      id: (json['id'] as num?)?.toInt(),
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      user: json['user'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      goalWeight: (json['goal_weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      birthDate: json['birth_date'] as String?,
      fitnessLevel: json['fitness_level'] as String?,
      fitnessGoal: json['fitness_goal'] as String?,
      certification: json['certification'] as String?,
      yearsOfExperience: (json['years_of_experience'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user': instance.user,
      'weight': instance.weight,
      'goal_weight': instance.goalWeight,
      'height': instance.height,
      'birth_date': instance.birthDate,
      'fitness_level': instance.fitnessLevel,
      'fitness_goal': instance.fitnessGoal,
      'certification': instance.certification,
      'years_of_experience': instance.yearsOfExperience,
    };
