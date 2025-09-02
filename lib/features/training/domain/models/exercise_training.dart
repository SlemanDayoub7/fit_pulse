import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';

class ExerciseTraining extends Exercise {
  final int? sets;
  final int? reps;

  ExerciseTraining({
    super.nameEn,
    super.nameAr,
    super.descriptionEn,
    super.descriptionAr,
    super.time,
    super.image,
    super.video,
    super.targetedMusclesEn,
    super.targetedMusclesAr,
    super.howToPlayEn,
    this.sets,
    this.reps,
  });
}
