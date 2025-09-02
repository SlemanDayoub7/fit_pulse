import 'package:gym_app/features/calories_calculator/domain/entites/gender.dart';

enum ActivityLevel {
  sedentary(1.2),
  lightlyActive(1.375),
  moderatelyActive(1.55),
  veryActive(1.725),
  extraActive(1.9);

  final double multiplier;
  const ActivityLevel(this.multiplier);
}

class CalculateCaloriesUseCase {
  double execute({
    required Gender gender,
    required int age,
    required double weight,
    required double height,
    required ActivityLevel activityLevel,
  }) {
    // Mifflin-St Jeor Equation
    final bmr = gender == Gender.male
        ? (10 * weight) + (6.25 * height) - (5 * age) + 5
        : (10 * weight) + (6.25 * height) - (5 * age) - 161;

    return bmr * activityLevel.multiplier;
  }
}
