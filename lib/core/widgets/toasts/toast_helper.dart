import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/widgets/toasts/app_bottom_sheet_toast.dart';

class ToastHelper {
  static void showToast(String message) {}

  static Future<void> showAppBottomSheetToast(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black87,
    TextStyle? textStyle,
    Duration duration = const Duration(seconds: 2),
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.1),
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      builder: (context) => AppBottomSheetToast(
        message: message,
        backgroundColor: backgroundColor,
        textStyle:
            textStyle ?? const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );

    await Future.delayed(duration);
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
