// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      token: json['token'] as String?,
    )
      ..email = json['email'] as String?
      ..access = json['access'] as String?
      ..refresh = json['refresh'] as String?
      ..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'access': instance.access,
      'refresh': instance.refresh,
      'id': instance.id,
      'token': instance.token,
    };
