import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/workouts/presentation/pages/monthly_workout_detail_page.dart';

class MonthlyWorkoutPlansPage extends StatefulWidget {
  @override
  _MonthlyWorkoutPlansPageState createState() =>
      _MonthlyWorkoutPlansPageState();
}

class _MonthlyWorkoutPlansPageState extends State<MonthlyWorkoutPlansPage> {
  String selectedCategory = 'All';
  List<String> categories = [
    'All',
    'Strength Training',
    'Cardio',
    'Yoga',
    'Pilates'
  ];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPlans =
        monthlyWorkoutPlans.where((plan) {
      final matchesCategory =
          selectedCategory == 'All' || plan['category'] == selectedCategory;
      final matchesSearch =
          plan['title'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search plans...',
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: AppColors.gray.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => setState(() => searchQuery = value),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (_, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: ChoiceChip(
                    iconTheme: IconThemeData(color: AppColors.white),
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) =>
                        setState(() => selectedCategory = category),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.white,
                    labelStyle: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.black),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlans.length,
              itemBuilder: (_, index) {
                final plan = filteredPlans[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MonthlyWorkoutDetailPage(
                            title: plan['title'],
                            image: plan['image'],
                            description: plan['description'],
                            weeks: plan['weeks'],
                          ),
                        ));
                  },
                  child: Card(
                    elevation: 0,
                    color: AppColors.primary.withOpacity(0.5),
                    margin: EdgeInsets.only(bottom: 12.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            bottomLeft: Radius.circular(12.r),
                          ),
                          child: Image.asset(
                            plan['image'],
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            plan['title'],
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white),
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: 16.sp),
                        SizedBox(width: 8.w),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> monthlyWorkoutPlans = [
  {
    'title': 'Monthly Strength Training',
    'image': 'assets/images/workout/strength.jpg',
    'description': 'A month-long strength training plan.',
    'category': 'Strength Training',
    'weeks': [
      {
        'title': 'Week 1: Introduction',
        'days': [
          {
            'day': 'Monday',
            'exercises': [
              {
                'name': 'Barbell Bench Press',
                'sets': 3,
                'reps': 8,
                'weight': '70 kg',
                'image': 'assets/images/workout/pushup.jpg'
              },
              {
                'name': 'Incline Dumbbell Press',
                'sets': 3,
                'reps': 10,
                'weight': '20 kg',
                'image': 'assets/images/workout/squate.jpg'
              },
            ]
          },
          {
            'day': 'Tuesday',
            'exercises': [
              {
                'name': 'Pull-ups',
                'sets': 3,
                'reps': 'as many as possible',
                'image': 'assets/pull_ups.jpg'
              },
              {
                'name': 'Barbell Rows',
                'sets': 3,
                'reps': 8,
                'weight': '60 kg',
                'image': 'assets/barbell_rows.jpg'
              },
            ]
          },
        ]
      },
      {
        'title': 'Week 2: Mid-Level',
        'days': [
          {
            'day': 'Monday',
            'exercises': [
              {
                'name': 'Barbell Bench Press',
                'sets': 3,
                'reps': 8,
                'weight': '70 kg',
                'image': 'assets/images/workout/pushup.jpg'
              },
              {
                'name': 'Incline Dumbbell Press',
                'sets': 3,
                'reps': 10,
                'weight': '20 kg',
                'image': 'assets/images/workout/squate.jpg'
              },
            ]
          },
          {
            'day': 'Tuesday',
            'exercises': [
              {
                'name': 'Pull-ups',
                'sets': 3,
                'reps': 'as many as possible',
                'image': 'assets/pull_ups.jpg'
              },
              {
                'name': 'Barbell Rows',
                'sets': 3,
                'reps': 8,
                'weight': '60 kg',
                'image': 'assets/barbell_rows.jpg'
              },
            ]
          },
        ]
      },
    ]
  }
];
