import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/private_workout/data/models/exercise.dart';

Widget buildExerciseRow(BuildContext context, Exercise exercise) {
  return Card(
    elevation: 4,
    margin: EdgeInsets.only(bottom: 15.h, left: 10.w, right: 10.w),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: AppColors.primary),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Details
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildExerciseStats(exercise),
                if (exercise.notes?.isNotEmpty ?? false)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      exercise.notes!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.mutedText,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: 15.w),
          Flexible(
            flex: 2,
            child: buildImagePreview(context, exercise.imagesPaths),
          ),
        ],
      ),
    ),
  );
}

Widget _buildExerciseStats(Exercise exercise) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildStatRow(Icons.repeat, 'Sets: ${exercise.sets}'),
      _buildStatRow(Icons.format_list_numbered,
          'Reps: ${exercise.repsPerSet.join(" - ")}'),
      _buildStatRow(Icons.timer_outlined, 'Rest: ${exercise.restSeconds} s'),
    ],
  );
}

Widget _buildStatRow(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      children: [
        Icon(icon, size: 16.w, color: AppColors.mutedText),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.mutedText,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

Widget buildImagePreview(BuildContext context, List<String> imagePaths) {
  return GestureDetector(
    onTap: () => showFullScreenImages(context, imagePaths),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 100.w,
        width: 100.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            imagePaths.length == 0
                ? Icon(Icons.image)
                : _buildMainImage(imagePaths.first),
            if (imagePaths.length > 1)
              Positioned(
                bottom: 5.w,
                right: 5.w,
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '+${imagePaths.length - 1}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildMainImage(String imagePath) {
  return Image.file(
    cacheHeight: 1000,
    cacheWidth: 1000,
    File(imagePath),
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) => Container(
      color: AppColors.gray.withOpacity(0.1),
      child: Center(
        child: Icon(
          Icons.broken_image,
          size: 30.w,
          color: AppColors.mutedText,
        ),
      ),
    ),
  );
}

void showFullScreenImages(BuildContext context, List<String> imagePaths,
    {int initialIndex = 0}) {
  final PageController pageController =
      PageController(initialPage: initialIndex);
  ValueNotifier<int> currentPage = ValueNotifier<int>(initialIndex);

  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                onPageChanged: (index) => currentPage.value = index,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        Navigator.pop(context);
                      }
                    },
                    child: InteractiveViewer(
                      transformationController: TransformationController(),
                      minScale: 0.1,
                      maxScale: 4.0,
                      child: Hero(
                        tag: imagePaths[index],
                        child: Image.file(
                          cacheHeight: 1000,
                          cacheWidth: 1000,
                          File(imagePaths[index]),
                          fit: BoxFit.contain,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) return child;
                            return AnimatedOpacity(
                              child: child,
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeOut,
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50.w,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Close Button
              Positioned(
                top: 40.h,
                right: 20.w,
                child: SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.close, size: 28.w, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              // Page Indicator
              if (imagePaths.length > 1)
                Positioned(
                  bottom: 40.h,
                  left: 0,
                  right: 0,
                  child: ValueListenableBuilder<int>(
                    valueListenable: currentPage,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(imagePaths.length, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: index == value ? 20.w : 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: index == value
                                  ? AppColors.primary
                                  : AppColors.paleBlue,
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    ),
  );
}
