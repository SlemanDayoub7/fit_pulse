import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/exercise.dart';
import 'package:gym_app/features/private_workout/presentation/widgets/exercise_row.dart';
import 'package:image_picker/image_picker.dart';

class ExerciseDialog extends StatefulWidget {
  final Function(Exercise) onExerciseAdded;

  const ExerciseDialog({super.key, required this.onExerciseAdded});

  @override
  State<ExerciseDialog> createState() => _ExerciseDialogState();
}

class _ExerciseDialogState extends State<ExerciseDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _restController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  List<TextEditingController> _repsControllers = [];
  List<String> images = [];

  @override
  void dispose() {
    _nameController.dispose();
    _setsController.dispose();
    _restController.dispose();
    _imagePathController.dispose();
    for (var controller in _repsControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      title: Text(
        'Add Workout',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Workout Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            TextField(
              controller: _setsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Sets Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
              onChanged: (val) {
                final sets = int.tryParse(val) ?? 0;
                setState(() {
                  _repsControllers =
                      List.generate(sets, (_) => TextEditingController());
                });
              },
            ),
            TextField(
              controller: _restController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Rest',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    List<XFile> temp = await ImagePicker().pickMultiImage();
                    images.clear();
                    temp.forEach((file) => images.add(file.path));
                    if (images.length != 0) {
                      setState(() {
                        _imagePathController.text = images.first;
                      });
                    }
                  },
                  child: const Text('Choose Images'),
                ),
                SizedBox(width: 10.w),
                Expanded(child: buildImagePreview(context, images)),
              ],
            ),
            ..._repsControllers.asMap().entries.map((entry) {
              final index = entry.key;
              final controller = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Reps Per Set ${index + 1}',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
              );
            }),
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
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          onPressed: () {
            final exercise = Exercise(
              name: _nameController.text,
              sets: _repsControllers.length,
              repsPerSet: _repsControllers
                  .map((c) => int.tryParse(c.text) ?? 0)
                  .toList(),
              restSeconds: int.tryParse(_restController.text) ?? 0,
              imagesPaths: images,
            );
            widget.onExerciseAdded(exercise);
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
