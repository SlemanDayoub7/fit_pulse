import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/helpers/validators.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/core/widgets/app_circular_indicator.dart';
import 'package:gym_app/core/widgets/app_scaffold.dart';
import 'package:gym_app/core/widgets/toasts/toast_helper.dart';
import 'package:gym_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gym_app/features/auth/presentation/pages/set_profile_info_page.dart';
import 'package:gym_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:gym_app/core/widgets/custom_text_field.dart';
import 'package:gym_app/features/auth/presentation/widgets/custom_top_auth.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';
import 'package:gym_app/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTopAuth(
                text: LocaleKeys.login_title.tr(),
              ),
              SizedBox(height: 50.h),
              CustomTextField(
                validator: Validator.emailValidator,
                controller: emailController,
                hintText: LocaleKeys.email.tr(),
              ),
              SizedBox(height: 40.h),
              // Password Field
              CustomTextField(
                validator: Validator.passwordValidate,
                isPassword: true,
                showPassword: showPassword,
                togglePassword: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                controller: passwordController,
                hintText: LocaleKeys.password.tr(),
              ),
              SizedBox(height: 50.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Authenticated) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
                  }
                  if (state is Unauthenticated) {
                    ToastHelper.showAppBottomSheetToast(
                        context, state.message ?? "error");
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: LocaleKeys.login.tr(),
                    enabled: state is! AuthLoading,
                    onPressed: () {
                      _login();
                      // context.router.replace(HomeAppRoute());
                    },
                    child: state is AuthLoading ? AppCircularIndicator() : null,
                  );
                },
              ),

              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(LocaleKeys.do_not_have_account.tr(),
                      style: AppText.s14w400),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text(LocaleKeys.create_account.tr(),
                        style:
                            AppText.s14w400.copyWith(color: AppColors.primary)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    if (formKey.currentState!.validate()) {
      if (passwordController.text.isNotEmpty &&
          emailController.text.trim().isNotEmpty) {
        context.read<AuthBloc>().add(LoginEvent(
            password: passwordController.text, email: emailController.text));
      }
    }
  }
}
