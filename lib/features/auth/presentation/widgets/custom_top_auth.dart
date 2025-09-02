import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/gen/assets.gen.dart';

class CustomTopAuth extends StatelessWidget {
  final String? text;
  const CustomTopAuth({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 438.h,
        child: Stack(
          children: [
            Assets.images.auth.authBackground
                .image(fit: BoxFit.fill, height: 438.h, width: double.infinity),
            Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.h),
                  child: Text(
                    text ?? '',
                    textAlign: TextAlign.center,
                    style: AppText.s22W500.copyWith(color: AppColors.primary),
                  ),
                ))
          ],
        ));
  }
}
