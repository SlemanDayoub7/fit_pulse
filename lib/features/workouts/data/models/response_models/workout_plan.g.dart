// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutPlan _$WorkoutPlanFromJson(Map<String, dynamic> json) => WorkoutPlan(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameAr: json['name_ar'] as String?,
      adviceEn: json['advice_en'] as String?,
      adviceAr: json['advice_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      planGoalEn: json['plan_goal_en'] as String?,
      planGoalAr: json['plan_goal_ar'] as String?,
      weeks: (json['weeks'] as num?)?.toInt(),
      image: json['image'] as String?,
      days: (json['days'] as num?)?.toInt(),
      dailyTime: json['daily_time'] as String?,
      kalories: (json['kalories'] as num?)?.toInt(),
      sportEn: json['sport_en'] as String?,
      sportAr: json['sport_ar'] as String?,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => WorkoutPlanDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WorkoutPlanToJson(WorkoutPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'advice_en': instance.adviceEn,
      'advice_ar': instance.adviceAr,
      'description_en': instance.descriptionEn,
      'description_ar': instance.descriptionAr,
      'plan_goal_en': instance.planGoalEn,
      'plan_goal_ar': instance.planGoalAr,
      'weeks': instance.weeks,
      'image': instance.image,
      'days': instance.days,
      'daily_time': instance.dailyTime,
      'kalories': instance.kalories,
      'sport_en': instance.sportEn,
      'sport_ar': instance.sportAr,
      'details': instance.details?.map((e) => e.toJson()).toList(),
      'owner': instance.owner?.toJson(),
    };

WorkoutPlanDetail _$WorkoutPlanDetailFromJson(Map<String, dynamic> json) =>
    WorkoutPlanDetail(
      id: (json['id'] as num?)?.toInt(),
      exercise: json['exercise'] == null
          ? null
          : Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      week: (json['week'] as num?)?.toInt(),
      day: (json['day'] as num?)?.toInt(),
      sets: (json['sets'] as num?)?.toInt(),
      repsEn: json['reps_en'] as String?,
      repsAr: json['reps_ar'] as String?,
    );

Map<String, dynamic> _$WorkoutPlanDetailToJson(WorkoutPlanDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exercise': instance.exercise?.toJson(),
      'week': instance.week,
      'day': instance.day,
      'sets': instance.sets,
      'reps_en': instance.repsEn,
      'reps_ar': instance.repsAr,
    };

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
      nameAr: json['name_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      descriptionAr: json['description_ar'] as String?,
      time: (json['time'] as num?)?.toInt(),
      image: json['image'] as String?,
      video: json['video'] as String?,
      targetedMusclesEn: (json['targeted_muscles_en'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      targetedMusclesAr: (json['targeted_muscles_ar'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      howToPlayEn: json['how_to_play_en'] as String?,
      howToPlayAr: json['how_to_play_ar'] as String?,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'description_en': instance.descriptionEn,
      'description_ar': instance.descriptionAr,
      'time': instance.time,
      'image': instance.image,
      'video': instance.video,
      'targeted_muscles_en': instance.targetedMusclesEn,
      'targeted_muscles_ar': instance.targetedMusclesAr,
      'how_to_play_en': instance.howToPlayEn,
      'how_to_play_ar': instance.howToPlayAr,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
    };
