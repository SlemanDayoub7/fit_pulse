import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';

class TimerWidget extends StatefulWidget {
  final int duration;
  final Function(int) onTimeUpdate;

  const TimerWidget({
    super.key,
    required this.duration,
    required this.onTimeUpdate,
  });

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late int _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _startTimer();
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _remainingTime = widget.duration;
      _timer.cancel();
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        widget.onTimeUpdate(_remainingTime);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primary),
      ),
      child: Text(
        '$minutes:$seconds',
        style: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
