import 'package:gym_app/core/packages.dart';

class AppCircularIndicator extends StatelessWidget {
  const AppCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.r,
      height: 50.r,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      ),
    );
  }
}
