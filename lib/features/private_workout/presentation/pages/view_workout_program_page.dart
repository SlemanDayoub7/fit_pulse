import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/workout_day.dart';
import 'package:gym_app/features/private_workout/data/models/workout_program.dart';
import 'package:gym_app/features/private_workout/presentation/pages/add_workout_program_page.dart';
import 'package:gym_app/features/private_workout/presentation/pages/workout_session_page.dart';

import 'package:gym_app/features/private_workout/presentation/widgets/exercise_row.dart';
import 'package:gym_app/features/workout_session/presentation/pages/workout_session_page.dart';

class ViewWorkoutProgramPage extends StatelessWidget {
  final WorkoutProgram program;
  final int index;

  const ViewWorkoutProgramPage({
    super.key,
    required this.program,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          program.name,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.r),
          ),
        ), // لون الشريط العلوي
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary, // لون الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddWorkoutProgramPage(
                c: 0,
                program: program,
                index: index,
                update: true,
                title: 'Edit Program',
              ),
            ),
          );
        },
        child: Text(
          'Edit',
          style: TextStyle(color: AppColors.white, fontSize: 16.sp), // لون النص
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: program.days.length,
          itemBuilder: (_, i) {
            final day = program.days[i];
            return _buildDayCard(context, day);
          },
        ),
      ),
    );
  }

  Widget _buildDayCard(BuildContext context, WorkoutDay day) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => WorkoutSessionPage(
        //               programId: program.id,
        //               workoutDay: day,
        //             )));
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        elevation: 4,
        shadowColor: AppColors.black.withOpacity(0.1), // لون الظل
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${day.dayOfWeek} - ${day.targetMuscles}',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text, // لون النص
                ),
              ),
              SizedBox(height: 15.h),
              ...day.exercises
                  .map((exercise) => buildExerciseRow(context, exercise)),
            ],
          ),
        ),
      ),
    );
  }
}
