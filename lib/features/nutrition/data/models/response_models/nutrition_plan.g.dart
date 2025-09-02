// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutritionPlan _$NutritionPlanFromJson(Map<String, dynamic> json) =>
    NutritionPlan(
      id: (json['id'] as num).toInt(),
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      target: json['target'] as String,
      descriptionEn: json['description_en'] as String,
      descriptionAr: json['description_ar'] as String,
      adviceEn: json['advice_en'] as String,
      adviceAr: json['advice_ar'] as String,
      weeks: (json['weeks'] as num).toInt(),
      image: json['image'] as String?,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      meals: (json['meals'] as List<dynamic>)
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NutritionPlanToJson(NutritionPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'target': instance.target,
      'description_en': instance.descriptionEn,
      'description_ar': instance.descriptionAr,
      'advice_en': instance.adviceEn,
      'advice_ar': instance.adviceAr,
      'weeks': instance.weeks,
      'image': instance.image,
      'owner': instance.owner.toJson(),
      'meals': instance.meals.map((e) => e.toJson()).toList(),
    };

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      id: (json['id'] as num).toInt(),
      week: (json['week'] as num).toInt(),
      day: (json['day'] as num).toInt(),
      mealNumber: (json['meal_number'] as num).toInt(),
      mealNameEn: json['meal_name_en'] as String,
      mealNameAr: json['meal_name_ar'] as String,
      calories: (json['calories'] as num).toInt(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fats: (json['fats'] as num).toDouble(),
      foodItems: (json['food_items'] as List<dynamic>)
          .map((e) => FoodItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'week': instance.week,
      'day': instance.day,
      'meal_number': instance.mealNumber,
      'meal_name_en': instance.mealNameEn,
      'meal_name_ar': instance.mealNameAr,
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fats': instance.fats,
      'food_items': instance.foodItems.map((e) => e.toJson()).toList(),
    };

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) => FoodItem(
      id: (json['id'] as num).toInt(),
      nameEn: json['name_en'] as String,
      nameAr: json['name_ar'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$FoodItemToJson(FoodItem instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
      'name_ar': instance.nameAr,
      'quantity': instance.quantity,
    };
