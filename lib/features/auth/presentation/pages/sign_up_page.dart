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
import 'package:gym_app/core/widgets/custom_text_field.dart';
import 'package:gym_app/core/widgets/toasts/toast_helper.dart';
import 'package:gym_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gym_app/features/auth/presentation/pages/login_page.dart';
import 'package:gym_app/features/auth/presentation/widgets/custom_top_auth.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                text: LocaleKeys.create_account_title.tr(),
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
                togglePassword: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                showPassword: showPassword,
                validator: Validator.passwordValidate,
                isPassword: true,
                controller: passwordController,
                hintText: LocaleKeys.password.tr(),
              ),
              SizedBox(height: 40.h),
              // Password Field
              CustomTextField(
                togglePassword: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                confirmPassword: Validator.confirmPasswordValidate(
                    passwordController.text, confirmPasswordController.text),
                controller: confirmPasswordController,
                isPassword: true,
                showPassword: showPassword,
                hintText: LocaleKeys.confirm_password.tr(),
              ),
              SizedBox(height: 50.h),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is Signedup) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  }
                  if (state is Unauthenticated) {
                    ToastHelper.showAppBottomSheetToast(
                        context, state.message ?? 'error');
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: LocaleKeys.create_account.tr(),
                    enabled: state is! AuthLoading,
                    onPressed: () {
                      _signup();
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
                  Text(LocaleKeys.already_have_account.tr(),
                      style: AppText.s14w400),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(LocaleKeys.login.tr(),
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

  void _signup() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(SignedIn(
          password: passwordController.text, email: emailController.text));
    }
  }
}
