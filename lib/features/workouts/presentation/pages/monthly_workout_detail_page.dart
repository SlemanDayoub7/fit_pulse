import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';

class MonthlyWorkoutDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final List<Map<String, dynamic>> weeks;

  const MonthlyWorkoutDetailPage({
    Key? key,
    required this.title,
    required this.image,
    required this.description,
    required this.weeks,
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
                Expanded(
                  child: DefaultTabController(
                    length: weeks.length,
                    child: Column(
                      children: [
                        TabBar(
                          indicatorColor: AppColors.primary,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: AppColors.primary,
                          tabs: weeks
                              .map((week) => Tab(
                                    text: week['title'],
                                  ))
                              .toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: weeks
                                .map((week) => _buildWeekView(week))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeekView(Map<String, dynamic> week) {
    return ListView(
      children: week['days'].map<Widget>((day) {
        return Card(
          elevation: 0,
          color: AppColors.primary.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day['day'],
                    style:
                        TextStyle(fontSize: 18.sp, color: AppColors.primary)),
                SizedBox(height: 8.h),
                ...day['exercises'].map<Widget>((exercise) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            exercise['image'],
                            width: 80.w,
                            height: 80.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.primary.withOpacity(0.2),
                                child: Icon(
                                  Icons.image,
                                  size: 100.w,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(exercise['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp)),
                              Text(
                                  '${exercise['sets']} sets of ${exercise['reps']} reps'),
                              if (exercise.containsKey('weight'))
                                Text('Weight: ${exercise['weight']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
