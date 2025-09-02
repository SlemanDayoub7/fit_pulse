import 'package:gym_app/core/localization/language_helpers.dart';
import 'package:gym_app/features/workouts/data/models/response_models/workout_plan.dart';

String localizedExerciseName(Exercise exercise) =>
    localizedText(en: exercise.nameEn, ar: exercise.nameAr);

String localizedExerciseDescription(Exercise exercise) =>
    localizedText(en: exercise.descriptionEn, ar: exercise.descriptionAr);

String localizedExerciseHowTo(Exercise exercise) =>
    localizedText(en: exercise.howToPlayEn, ar: exercise.howToPlayAr);

List<String> localizedExerciseMuscles(Exercise exercise) =>
    getCurrentLanguage() == 'ar'
        ? exercise.targetedMusclesAr ?? []
        : exercise.targetedMusclesEn ?? [];
