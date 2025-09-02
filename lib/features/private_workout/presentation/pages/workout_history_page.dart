import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/workout_log.dart';
import 'package:gym_app/features/private_workout/data/data_source/workout_log_storage.dart';

class WorkoutHistoryPage extends StatefulWidget {
  const WorkoutHistoryPage({super.key});

  @override
  State<WorkoutHistoryPage> createState() => _WorkoutHistoryPageState();
}

class _WorkoutHistoryPageState extends State<WorkoutHistoryPage> {
  List<WorkoutLog> logs = [];

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    final allLogs = await WorkoutLogStorage.loadLogs();
    setState(() => logs = allLogs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("سجل التمارين"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: logs.isEmpty
          ? const Center(child: Text("لا يوجد تمارين مسجلة بعد."))
          : ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: AppColors.cardBackground,
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "التمرين: ${log.exerciseName}",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                            "التاريخ: ${log.date.toLocal().toString().split(" ")[0]}",
                            style: TextStyle(
                                fontSize: 14.sp, color: AppColors.gray)),
                        SizedBox(height: 8.h),
                        Text("الجولات:",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600)),
                        ...log.sets.asMap().entries.map(
                              (entry) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.h),
                                child: Text(
                                    "جولة ${entry.key + 1}: عدد العدات ${entry.value.reps}, الوزن ${entry.value.weight} كغ",
                                    style: TextStyle(fontSize: 14.sp)),
                              ),
                            ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
