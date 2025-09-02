// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String?,
      id: (json['id'] as num?)?.toInt(),
      access: json['access'] as String?,
      refresh: json['refresh'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'access': instance.access,
      'refresh': instance.refresh,
      'id': instance.id,
    };
