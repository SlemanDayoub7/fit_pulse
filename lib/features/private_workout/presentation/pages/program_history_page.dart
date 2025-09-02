import 'package:flutter/material.dart';
import 'package:gym_app/features/private_workout/data/data_source/program_log_storage.dart';
import 'package:gym_app/features/private_workout/data/models/program_log.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';

class ProgramHistoryPage extends StatefulWidget {
  const ProgramHistoryPage({super.key});

  @override
  State<ProgramHistoryPage> createState() => _ProgramHistoryPageState();
}

class _ProgramHistoryPageState extends State<ProgramHistoryPage> {
  late Future<List<ProgramLog>> programLogs;

  @override
  void initState() {
    super.initState();
    programLogs = ProgramLogStorage.loadLogs(); // تحميل السجلات عند بدء الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("سجل البرامج"),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: FutureBuilder<List<ProgramLog>>(
          future: programLogs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("لا توجد برامج مدرجة في السجل."));
            }

            final logs = snapshot.data!;

            return ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final program = logs[index];

                return Card(
                  margin: EdgeInsets.only(bottom: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 5,
                  color: AppColors.cardBackground,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.programName,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'تاريخ التمرين: ${program.date.toLocal()}'
                              .split(' ')[0], // فقط التاريخ
                          style:
                              TextStyle(fontSize: 16.sp, color: AppColors.gray),
                        ),
                        SizedBox(height: 12.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: program.exercises.map((exercise) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'التمرين: ${exercise.exerciseName}',
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 6.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: exercise.sets.map((set) {
                                      return Text(
                                        'جولة: ${set.reps} عدات، وزن: ${set.weight} كغ',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.gray,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
