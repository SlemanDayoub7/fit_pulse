import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';

class WorkoutDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final String duration;
  final String goal;
  final String difficulty;
  final Map<String, String> warmUp;
  final List<Map<String, String>> exercises;

  const WorkoutDetailPage({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
    required this.duration,
    required this.goal,
    required this.difficulty,
    required this.warmUp,
    required this.exercises,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.h,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.primary,
                      child: Icon(
                        Icons.image,
                        size: 100.w,
                      ),
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: AppColors.primary.withOpacity(0.1),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
                color: AppColors.white,
                border:
                    Border(top: BorderSide(color: AppColors.gray, width: 1.w)),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(description, style: TextStyle(fontSize: 16.sp)),
                Divider(height: 24.h),
                Text('Workout Overview',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.h),
                Text('Duration: $duration'),
                Text('Goal: $goal'),
                Text('Difficulty: $difficulty'),
                SizedBox(height: 8.h),
                Text('Warm-Up:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(warmUp['description']!),
                Divider(height: 24.h),
                Text('Exercises',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.h),
                Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  children: _buildExerciseList(exercises),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExerciseList(List<Map<String, String>> exercises) {
    return exercises.map((exercise) {
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.sports,
                    size: 45.h,
                  );
                },
                exercise['image']!,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise['name']!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  Text(exercise['description']!,
                      style: TextStyle(fontSize: 14.sp)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
