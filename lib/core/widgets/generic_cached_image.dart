import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';

class GenericCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const GenericCachedImage({
    Key? key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil if not initialized earlier in the app

    return CachedNetworkImage(
      imageUrl: 'https://ahmadshamma.pythonanywhere.com/$imageUrl',
      width: width.w, // Using flutter_screen_util's responsive width
      height: height.h, // Using flutter_screen_util's responsive height
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          Center(
            child: SizedBox(
              width: 30.w,
              height: 30.h,
              child: CircularProgressIndicator(
                color: AppColors.darkGray,
              ),
            ),
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Center(
            child: Icon(
              Icons.broken_image,
              size: 40.sp,
              color: Colors.grey,
            ),
          ),
    );
  }
}
