import 'package:flutter/widgets.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension UserProfileModelExtensions on UserProfileModel {
  bool get isProfileComplete {
    return firstName != null &&
        firstName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty &&
        user != null &&
        user!.isNotEmpty &&
        weight != null &&
        weight! > 0 &&
        goalWeight != null &&
        goalWeight! > 0 &&
        height != null &&
        height! > 0 &&
        birthDate != null &&
        birthDate!.isNotEmpty &&
        fitnessLevel != null &&
        fitnessLevel!.isNotEmpty &&
        fitnessGoal != null &&
        fitnessGoal!.isNotEmpty &&
        certification != null &&
        certification!.isNotEmpty &&
        yearsOfExperience != null;
  }
}
