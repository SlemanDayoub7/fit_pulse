import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/features/auth/presentation/pages/login_page.dart';
import 'package:gym_app/features/auth/presentation/pages/sign_up_page.dart';

import 'package:gym_app/features/auth/presentation/widgets/custom_top_auth.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';

class AuthSelectionPage extends StatelessWidget {
  const AuthSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTopAuth(),
            SizedBox(height: 36.h),
            Text(
              LocaleKeys.auth_selection_title.tr(),
              style: AppText.s22W500,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 70.h),
            AppButton(
              title: LocaleKeys.login.tr(),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
            ),
            SizedBox(height: 57.h),
            AppButton(
              backgroundColor: AppColors.white,
              title: LocaleKeys.create_account.tr(),
              textColor: AppColors.primary,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
