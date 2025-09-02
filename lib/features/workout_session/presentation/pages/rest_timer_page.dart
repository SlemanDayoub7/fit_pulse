import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';

import '../../../../generated/codegen_loader.g.dart';

class RestTimerPage extends StatefulWidget {
  @override
  _RestTimerPageState createState() => _RestTimerPageState();
}

class _RestTimerPageState extends State<RestTimerPage>
    with SingleTickerProviderStateMixin {
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  int selectedTime = 10; // default rest time in seconds
  Timer? timer;
  int currentTime = 0;
  bool isRunning = false;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    currentTime = selectedTime;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 1.0,
      upperBound: 1.3,
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void startTimer() {
    if (isRunning) return;
    setState(() {
      isRunning = true;
      currentTime = selectedTime;
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentTime == 0) {
        timer.cancel();
        setState(() => isRunning = false);
        Navigator.pop(context);
      } else {
        setState(() {
          currentTime--;
          animationController.forward(from: 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isRunning, // Allow back only when timer not running
      onPopInvokedWithResult: (context, didPop) {
        // Optional: react to pop gesture result here, if needed
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.scroll_to_set_rest_time.tr(),
                  style: AppText.s20W600),
              SizedBox(height: 20.h),
              SizedBox(
                height: 150.h,
                child: ListWheelScrollView.useDelegate(
                  controller: scrollController,
                  itemExtent: 50.h,
                  physics: isRunning
                      ? NeverScrollableScrollPhysics()
                      : FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    if (!isRunning) {
                      setState(() {
                        selectedTime = index + 1; // seconds from 1 to 60
                        currentTime = selectedTime;
                      });
                    }
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= 60) return null;
                      return Center(
                        child: Text(
                          '${index + 1}',
                          style: AppText.s18W500.copyWith(
                              fontSize: 30.sp,
                              color: selectedTime == index + 1
                                  ? Colors.blue
                                  : Colors.black54),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              AnimatedBuilder(
                animation: animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: animationController.value,
                    child: Text(
                      '${currentTime}s',
                      style: AppText.s28W700.copyWith(
                          fontSize: 70.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    ),
                  );
                },
              ),
              SizedBox(height: 50.h),
              ElevatedButton(
                onPressed: isRunning ? null : startTimer,
                child: Text(
                    isRunning ? LocaleKeys.running.tr() : LocaleKeys.start.tr(),
                    style: AppText.s18W500),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
