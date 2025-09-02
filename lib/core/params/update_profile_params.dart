import 'package:equatable/equatable.dart';

class UpdateProfileParams extends Equatable {
  final String firstName;
  final String lastName;

  final String weight;
  final String goalWeight;
  final int height;

  const UpdateProfileParams({
    required this.firstName,
    required this.lastName,
    required this.weight,
    required this.goalWeight,
    required this.height,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        weight,
        goalWeight,
        height,
      ];
}
