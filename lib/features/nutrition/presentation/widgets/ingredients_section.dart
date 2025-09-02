import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IngredientsSection extends StatelessWidget {
  final List<String> ingredients;

  const IngredientsSection({Key? key, required this.ingredients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المكونات',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: ingredients.map((ingredient) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Text(
                '• $ingredient',
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
