import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/exercise.dart';
import 'package:gym_app/features/private_workout/data/models/workout_day.dart';
import 'exercise_dialog.dart';

class WorkoutDayDialog extends StatefulWidget {
  final Function(WorkoutDay) onDayAdded;

  const WorkoutDayDialog({super.key, required this.onDayAdded});

  @override
  State<WorkoutDayDialog> createState() => _WorkoutDayDialogState();
}

class _WorkoutDayDialogState extends State<WorkoutDayDialog> {
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _muscleController = TextEditingController();
  final List<Exercise> _exercises = [];

  void _addExercise(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => ExerciseDialog(
        onExerciseAdded: (exercise) => setState(() => _exercises.add(exercise)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        'Add Training Day',
        style: TextStyle(fontSize: 18.sp, color: AppColors.text),
      ),
      content: SingleChildScrollView(
        child: Column(
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dayController,
              decoration: InputDecoration(
                labelText: 'Day',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            TextField(
              controller: _muscleController,
              decoration: InputDecoration(
                labelText: 'Target Mucsels',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => _addExercise(context),
              child: const Text('Add Workout'),
            ),
            ..._exercises.map((e) => ListTile(
                  title: Text(e.name),
                  subtitle: Text(
                      '${e.sets} Sets - ${e.repsPerSet.join(", ")} Reps - Rest ${e.restSeconds}s'),
                  trailing: e.imagesPaths.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(e.imagesPaths.first),
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                )),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancle',
            style: TextStyle(color: AppColors.mutedText),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            widget.onDayAdded(WorkoutDay(
              dayOfWeek: _dayController.text,
              targetMuscles: _muscleController.text,
              exercises: _exercises,
            ));
            Navigator.pop(context);
          },
          child: const Text('Save Day'),
        ),
      ],
    );
  }
}
