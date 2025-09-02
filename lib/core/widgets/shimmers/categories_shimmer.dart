import 'package:gym_app/core/packages.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 6, // number of shimmer categories
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (_, __) => Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.grey.shade300,
                ),
                width: 80.w,
                height: 30.h,
              )),
    );
  }
}
