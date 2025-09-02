import 'package:easy_localization/easy_localization.dart' as es;
import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/screens.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            children: [
              _buildOnboardingSlide(
                title: LocaleKeys.onboarding_one_title.tr(),
                subtitle: LocaleKeys.onboarding_one_subtitle.tr(),
                image: Assets.images.onboarding.onboarding1.image(
                    width: 1.sw, height: double.infinity, fit: BoxFit.fill),
              ),
              _buildOnboardingSlide(
                title: LocaleKeys.onboarding_two_title.tr(),
                subtitle: LocaleKeys.onboarding_two_subtitle.tr(),
                image: Assets.images.onboarding.onboarding2.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill),
              ),
              _buildOnboardingSlide(
                title: LocaleKeys.onboarding_three_title.tr(),
                subtitle: LocaleKeys.onboarding_three_subtitle.tr(),
                image: Assets.images.onboarding.onboarding3.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill),
              ),
            ],
          ),
          Positioned.directional(
              top: 34.h,
              end: 36.w,
              textDirection: TextDirection.rtl,
              child: InkWell(
                onTap: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AuthSelectionPage()),
                    );
                  }
                },
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.skip.tr(),
                      style: AppText.s16W500.copyWith(color: AppColors.white),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 2.h,
                      width: 68.w,
                      decoration: BoxDecoration(color: AppColors.white),
                    )
                  ],
                ),
              )),
          Positioned(
            bottom: 40.h,
            child: SizedBox(
              width: 1.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => Container(
                    width: 98.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                        color: _currentPage == index
                            ? AppColors.primary
                            : AppColors.gray,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingSlide({
    required String title,
    required String subtitle,
    required Widget image,
  }) {
    return Stack(
      children: [
        image,
        Positioned(
          bottom: 208.h,
          right: 35.w,
          child: SizedBox(
            width: 246.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: AppText.heading.copyWith(color: AppColors.white)),
                SizedBox(height: 10.h),
                Text(
                  overflow: TextOverflow.visible,
                  subtitle,
                  style: AppText.s16W500.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
