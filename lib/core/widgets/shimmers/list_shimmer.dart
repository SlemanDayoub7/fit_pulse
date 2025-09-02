import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/widgets/generic_shimmer.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (_, __) => Padding(
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
            ));
  }
}
