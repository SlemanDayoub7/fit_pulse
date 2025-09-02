import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheetToast extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final TextStyle textStyle;

  const AppBottomSheetToast({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.black87,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: SafeArea(
        top: false,
        child: Text(
          message,
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
