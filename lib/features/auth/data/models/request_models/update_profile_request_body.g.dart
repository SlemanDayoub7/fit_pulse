// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequestBody _$UpdateProfileRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequestBody(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      weight: json['weight'] as String,
      goalWeight: json['goal_weight'] as String,
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateProfileRequestBodyToJson(
        UpdateProfileRequestBody instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'weight': instance.weight,
      'goal_weight': instance.goalWeight,
      'height': instance.height,
    };
