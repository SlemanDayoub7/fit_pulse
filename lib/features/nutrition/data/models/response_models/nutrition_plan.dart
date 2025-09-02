import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nutrition_plan.g.dart';

@JsonSerializable(explicitToJson: true)
class NutritionPlan {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  final String target;
  @JsonKey(name: 'description_en')
  final String descriptionEn;
  @JsonKey(name: 'description_ar')
  final String descriptionAr;
  @JsonKey(name: 'advice_en')
  final String adviceEn;
  @JsonKey(name: 'advice_ar')
  final String adviceAr;
  final int weeks;
  final String? image;
  final Owner owner;
  final List<Meal> meals;

  NutritionPlan({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.target,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.adviceEn,
    required this.adviceAr,
    required this.weeks,
    this.image,
    required this.owner,
    required this.meals,
  });

  factory NutritionPlan.fromJson(Map<String, dynamic> json) =>
      _$NutritionPlanFromJson(json);
  Map<String, dynamic> toJson() => _$NutritionPlanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Meal {
  final int id;
  final int week;
  final int day;
  @JsonKey(name: 'meal_number')
  final int mealNumber;
  @JsonKey(name: 'meal_name_en')
  final String mealNameEn;
  @JsonKey(name: 'meal_name_ar')
  final String mealNameAr;
  final int calories;
  final double protein;
  final double carbs;
  final double fats;
  @JsonKey(name: 'food_items')
  final List<FoodItem> foodItems;

  Meal({
    required this.id,
    required this.week,
    required this.day,
    required this.mealNumber,
    required this.mealNameEn,
    required this.mealNameAr,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.foodItems,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);
}

@JsonSerializable()
class FoodItem {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  final int quantity;

  FoodItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.quantity,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) =>
      _$FoodItemFromJson(json);
  Map<String, dynamic> toJson() => _$FoodItemToJson(this);
}
