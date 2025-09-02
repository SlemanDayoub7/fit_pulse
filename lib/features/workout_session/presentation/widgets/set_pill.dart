import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetPill extends StatelessWidget {
  final int index;
  final int reps;
  const SetPill({super.key, required this.index, required this.reps});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) {
        return Transform.translate(
          offset: Offset(0, (1 - t) * 6),
          child: Opacity(opacity: t, child: child),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: cs.secondaryContainer,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 10.r,
              backgroundColor: cs.onSecondaryContainer.withOpacity(0.1),
              child: Text('$index',
                  style:
                      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 8.w),
            Text('x$reps',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
