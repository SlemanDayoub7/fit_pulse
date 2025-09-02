import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/widgets/generic_shimmer.dart';

class WorkoutPlanShimmerItem extends StatelessWidget {
  const WorkoutPlanShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Customize these sizes according to your WorkoutPlanWidget actual sizes
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          GenericShimmer(
            width: 80.w,
            height: 80.h,
            borderRadius: BorderRadius.circular(12.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GenericShimmer(width: double.infinity, height: 20.h),
                SizedBox(height: 6.h),
                GenericShimmer(width: 150.w, height: 16.h),
                SizedBox(height: 6.h),
                GenericShimmer(width: 100.w, height: 14.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
