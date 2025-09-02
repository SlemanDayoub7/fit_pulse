import 'package:json_annotation/json_annotation.dart';

part 'workout_plan.g.dart';

@JsonSerializable(explicitToJson: true)
class WorkoutPlan {
  final int? id;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  @JsonKey(name: 'name_ar')
  final String? nameAr;

  @JsonKey(name: 'advice_en')
  final String? adviceEn;

  @JsonKey(name: 'advice_ar')
  final String? adviceAr;

  @JsonKey(name: 'description_en')
  final String? descriptionEn;

  @JsonKey(name: 'description_ar')
  final String? descriptionAr;

  @JsonKey(name: 'plan_goal_en')
  final String? planGoalEn;

  @JsonKey(name: 'plan_goal_ar')
  final String? planGoalAr;

  final int? weeks;
  final String? image;
  final int? days;

  @JsonKey(name: 'daily_time')
  final String? dailyTime;

  final int? kalories;

  @JsonKey(name: 'sport_en')
  final String? sportEn;

  @JsonKey(name: 'sport_ar')
  final String? sportAr;

  final List<WorkoutPlanDetail>? details;
  final Owner? owner;

  WorkoutPlan({
    this.id,
    this.nameEn,
    this.nameAr,
    this.adviceEn,
    this.adviceAr,
    this.descriptionEn,
    this.descriptionAr,
    this.planGoalEn,
    this.planGoalAr,
    this.weeks,
    this.image,
    this.days,
    this.dailyTime,
    this.kalories,
    this.sportEn,
    this.sportAr,
    this.details,
    this.owner,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutPlanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutPlanDetail {
  final int? id;
  final Exercise? exercise;
  final int? week;
  final int? day;
  final int? sets;

  @JsonKey(name: 'reps_en')
  final String? repsEn;

  @JsonKey(name: 'reps_ar')
  final String? repsAr;

  WorkoutPlanDetail({
    this.id,
    this.exercise,
    this.week,
    this.day,
    this.sets,
    this.repsEn,
    this.repsAr,
  });

  factory WorkoutPlanDetail.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanDetailFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutPlanDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Exercise {
  final int? id;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  @JsonKey(name: 'name_ar')
  final String? nameAr;

  @JsonKey(name: 'description_en')
  final String? descriptionEn;

  @JsonKey(name: 'description_ar')
  final String? descriptionAr;

  final int? time;
  final String? image;
  final String? video;

  @JsonKey(name: 'targeted_muscles_en')
  final List<String>? targetedMusclesEn;

  @JsonKey(name: 'targeted_muscles_ar')
  final List<String>? targetedMusclesAr;

  @JsonKey(name: 'how_to_play_en')
  final String? howToPlayEn;

  @JsonKey(name: 'how_to_play_ar')
  final String? howToPlayAr;

  Exercise({
    this.id,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.time,
    this.image,
    this.video,
    this.targetedMusclesEn,
    this.targetedMusclesAr,
    this.howToPlayEn,
    this.howToPlayAr,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}

@JsonSerializable()
class Owner {
  final int? id;
  final String? email;

  Owner({this.id, this.email});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
