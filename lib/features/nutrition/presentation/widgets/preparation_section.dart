import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PreparationSection extends StatelessWidget {
  final String preparation;

  const PreparationSection({Key? key, required this.preparation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'طريقة التحضير',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          preparation,
          style: TextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }
}
