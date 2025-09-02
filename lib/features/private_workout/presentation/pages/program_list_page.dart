import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/workout_program.dart';
import 'package:gym_app/features/private_workout/presentation/bloc/workout_program_cubit.dart';
import 'package:gym_app/features/private_workout/presentation/pages/exercise_history_page.dart';
import 'package:gym_app/features/private_workout/presentation/pages/program_history_page.dart';
import 'package:gym_app/features/private_workout/presentation/pages/view_workout_program_page.dart';
import 'package:gym_app/features/private_workout/presentation/pages/workout_history_page.dart';
import 'package:gym_app/features/weight_tracker/presentation/pages/home_weight.dart';
import 'add_workout_program_page.dart';

class ProgramsListPage extends StatefulWidget {
  ProgramsListPage({super.key});

  @override
  State<ProgramsListPage> createState() => _ProgramsListPageState();
}

class _ProgramsListPageState extends State<ProgramsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Programs'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16.r),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgramHistoryPage()),
              );
            },
            icon: Icon(Icons.lock_clock),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExerciseHistoryPage()),
              );
            },
            icon: Icon(Icons.lock_clock),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: BlocBuilder<WorkoutProgramCubit, List<WorkoutProgram>>(
        builder: (context, programs) {
          // في حال كانت القائمة فارغة
          if (programs.isEmpty) {
            return Center(
              child: Text(
                'No Saved Programs',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.mutedText,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: programs.length,
            itemBuilder: (_, i) => Card(
              color: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 4,
              shadowColor: AppColors.shadow, // لون الظل
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: ListTile(
                contentPadding: EdgeInsets.all(12.w),
                title: Text(
                  programs[i].name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${programs[i].days.length} Days',
                  style: TextStyle(fontSize: 16.sp, color: AppColors.mutedText),
                ),
                trailing: IconButton(
                  onPressed: () {
                    context.read<WorkoutProgramCubit>().deleteProgram(i);
                  },
                  icon: Icon(Icons.remove, color: Colors.red),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewWorkoutProgramPage(
                      program: programs[i],
                      index: i,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        onPressed: () {
          final c = context.read<WorkoutProgramCubit>().state.length;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddWorkoutProgramPage(c: c),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
