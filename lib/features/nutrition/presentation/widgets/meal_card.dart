import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/screens.dart';

class MealCard extends StatelessWidget {
  final String title;
  final String calories;
  final String description;
  final String imagePath;

  const MealCard({
    super.key,
    required this.title,
    required this.calories,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailsPage(),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.nutritionPrimary),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                errorBuilder: (context, error, stackTrace) => SizedBox(
                  width: 133.w,
                  height: 125.w,
                ),
                imagePath,
                cacheHeight: 100,
                cacheWidth: 100,
                width: 133.w,
                height: 125.w,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.all(10.w),
              width: 200.w,
              height: 125.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: AppText.s14w600),
                      Text(
                        '$calories سعرة',
                        style: AppText.s14w600.copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(description, style: AppText.s12w400),
                  Spacer(),
                  Row(
                    spacing: 20.w,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle show meal
                          },
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.nutritionPrimary,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "عرض الوجبة",
                              textAlign: TextAlign.center,
                              style:
                                  AppText.s14w600.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Handle show alternative
                          },
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.nutritionPrimary),
                              borderRadius: BorderRadius.circular(8.r),
                              color: Colors.transparent,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "عرض البديل",
                              textAlign: TextAlign.center,
                              style: AppText.s14w600
                                  .copyWith(color: AppColors.nutritionPrimary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
