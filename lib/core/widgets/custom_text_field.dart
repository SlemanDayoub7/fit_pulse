import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/helpers/validators.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool isPassword;
  final Color? fillColor;
  final Function(String)? validator;
  final String? confirmPassword;
  final bool? showPassword;
  final Function? togglePassword;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.hintText,
    this.isPassword = false,
    this.fillColor = AppColors.offPrimary,
    required this.controller,
    this.validator,
    this.confirmPassword,
    this.keyboardType,
    this.onChanged,
    this.showPassword = false,
    this.togglePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      child: TextFormField(
        onChanged: (value) {
          if (onChanged != null) {
            onChanged!(value);
          }
        },
        keyboardType: keyboardType,
        validator: (value) {
          if (confirmPassword != null) return confirmPassword;
          if (validator != null) {
            validator!(value!);
          }
          if (validator != null) {
            return validator!(value ?? '');
          }
          return Validator.defaultValidator(value) ? 'خطأ' : null;
        },
        controller: controller,
        obscureText: isPassword && !showPassword!,
        style: AppText.s14w400,
        decoration: InputDecoration(
          suffixIcon: !isPassword
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    togglePassword!();
                  },
                  child: Icon(
                    showPassword! ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.black,
                  ),
                ),
          filled: true,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          labelText: hintText,
          labelStyle:
              AppText.s14w400.copyWith(fontSize: 20.sp, color: AppColors.black),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
