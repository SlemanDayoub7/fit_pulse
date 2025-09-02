import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/workout_day.dart';
import 'package:gym_app/features/private_workout/data/models/workout_program.dart';
import 'package:gym_app/features/private_workout/presentation/bloc/workout_program_cubit.dart';
import 'package:gym_app/features/private_workout/presentation/widgets/dialog_service.dart';
import 'package:gym_app/features/private_workout/presentation/widgets/exercise_row.dart';

class AddWorkoutProgramPage extends StatefulWidget {
  final WorkoutProgram? program;
  final int? index;
  final String? title;
  final int c;
  final bool? update;
  const AddWorkoutProgramPage(
      {super.key,
      this.program,
      this.index,
      this.title,
      this.update = false,
      required this.c});

  @override
  State<AddWorkoutProgramPage> createState() => _AddWorkoutProgramPageState();
}

class _AddWorkoutProgramPageState extends State<AddWorkoutProgramPage> {
  TextEditingController nameController = TextEditingController();
  List<WorkoutDay> days = [];

  @override
  void initState() {
    super.initState();
    if (widget.program != null) {
      nameController = TextEditingController(text: widget.program!.name);
      days = List.from(widget.program!.days);
    }
  }

  void _saveProgram() {
    if (nameController.text.isEmpty) return;
    final program = WorkoutProgram(
      name: nameController.text,
      days: days,
      id: widget.update! ? widget.program!.id : (widget.c + 1).toString(),
    );
    if (widget.update!) {
      context.read<WorkoutProgramCubit>().updateProgram(widget.index!, program);
      Navigator.pop(context);
    } else
      context.read<WorkoutProgramCubit>().addProgram(program);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Add Workout Program'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.r),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Program Name',
                filled: true,
                fillColor: AppColors.white,
                labelStyle: TextStyle(color: AppColors.mutedText),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: () => DialogService.showWorkoutDayDialog(
                context: context,
                onDayAdded: (newDay) => setState(() => days.add(newDay)),
              ),
              child: Text(
                'Add Day',
                style: TextStyle(color: AppColors.white),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: days.length,
                itemBuilder: (_, i) => Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 2,
                  shadowColor: AppColors.shadow, // لون الظل
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            '${days[i].dayOfWeek} - ${days[i].targetMuscles}',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => setState(() {
                              days.removeAt(i);
                              print(days.length);
                            }),
                          ),
                        ),
                        ...days[i]
                            .exercises
                            .map((e) => buildExerciseRow(context, e)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPressed: _saveProgram,
              child: Text(
                'Save',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
