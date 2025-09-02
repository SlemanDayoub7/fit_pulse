// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sport _$SportFromJson(Map<String, dynamic> json) => Sport(
      id: (json['id'] as num).toInt(),
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
    );

Map<String, dynamic> _$SportToJson(Sport instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
    };
