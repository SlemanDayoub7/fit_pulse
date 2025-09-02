import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  final double? minimumHeight;
  final double? minimumWidth;
  final double? maxHeight;
  final double? maxWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? child;
  final bool enabled;
  AppButton({
    super.key,
    this.title,
    this.onPressed,
    this.minimumHeight,
    this.minimumWidth,
    this.backgroundColor,
    this.textColor = AppColors.white,
    this.enabled = true,
    this.child,
    this.maxHeight,
    this.maxWidth,
  });
  final StreamController<bool> loadingController = StreamController<bool>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        minimumSize: Size(minimumWidth ?? 332.w, minimumHeight ?? 50.h),
        maximumSize: Size(maxWidth ?? 332.w, maxHeight ?? 50.h),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      onPressed: enabled
          ? () async {
              loadingController.sink.add(true);
              try {
                if (onPressed != null) await onPressed!();
              } catch (e, s) {
                loadingController.sink.add(false);
              }
              loadingController.sink.add(false);
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (child != null) ...[child!],
          title == null
              ? SizedBox.shrink()
              : Text(title ?? '',
                  style: AppText.s14w400.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
