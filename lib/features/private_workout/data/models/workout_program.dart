import 'package:gym_app/features/private_workout/data/models/workout_day.dart';

class WorkoutProgram {
  final String name;
  final String id;
  final List<WorkoutDay> days;

  WorkoutProgram({
    required this.id,
    required this.name,
    required this.days,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'days': days.map((d) => d.toJson()).toList(),
      };

  factory WorkoutProgram.fromMap(Map<String, dynamic> map) => WorkoutProgram(
        name: map['name'],
        id: map['id'],
        days: List<WorkoutDay>.from(
            map['days'].map((d) => WorkoutDay.fromJson(d))),
      );
}
