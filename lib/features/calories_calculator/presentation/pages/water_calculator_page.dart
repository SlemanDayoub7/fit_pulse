import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/core/widgets/custom_text_field.dart';
import 'package:gym_app/core/helpers/validators.dart';
import 'package:gym_app/features/calories_calculator/domain/entites/gender.dart';

class WaterCalculatorPage extends StatelessWidget {
  const WaterCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text('Water Intake Calculator', style: AppText.heading),
      ),
      body: const _WaterCalculatorForm(),
    );
  }
}

class _WaterCalculatorForm extends StatefulWidget {
  const _WaterCalculatorForm();

  @override
  State<_WaterCalculatorForm> createState() => _WaterCalculatorFormState();
}

class _WaterCalculatorFormState extends State<_WaterCalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  Gender _selectedGender = Gender.male;
  double? _waterAmount;

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _calculateWater() {
    if (_formKey.currentState!.validate()) {
      final weight = double.parse(_weightController.text);
      // Simple formula: 35ml per kg for men, 31ml per kg for women
      final multiplier = _selectedGender == Gender.male ? 35 : 31;
      setState(() {
        _waterAmount = weight * multiplier / 1000; // in liters
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _GenderRadio(
                  label: 'Male',
                  gender: Gender.male,
                  selectedGender: _selectedGender,
                  onChanged: (g) => setState(() => _selectedGender = g),
                ),
                SizedBox(width: 40.w),
                _GenderRadio(
                  label: 'Female',
                  gender: Gender.female,
                  selectedGender: _selectedGender,
                  onChanged: (g) => setState(() => _selectedGender = g),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              controller: _weightController,
              hintText: 'Weight (kg)',
              keyboardType: TextInputType.number,
              validator: (v) =>
                  Validator.validateNumber(v, fieldName: 'Weight'),
            ),
            SizedBox(height: 30.h),
            AppButton(
              title: 'Calculate Water Intake',
              onPressed: _calculateWater,
            ),
            SizedBox(height: 30.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _waterAmount == null
                  ? const SizedBox.shrink()
                  : Container(
                      key: ValueKey(_waterAmount),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.nutritionPrimary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Text(
                        'Recommended daily water intake:\n${_waterAmount!.toStringAsFixed(2)} liters',
                        textAlign: TextAlign.center,
                        style: AppText.s20W600.copyWith(
                          color: AppColors.nutritionPrimary,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderRadio extends StatelessWidget {
  final String label;
  final Gender gender;
  final Gender selectedGender;
  final Function(Gender) onChanged;

  const _GenderRadio({
    required this.label,
    required this.gender,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = gender == selectedGender;
    return GestureDetector(
      onTap: () => onChanged(gender),
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.nutritionPrimary : AppColors.offPrimary,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isSelected ? AppColors.nutritionPrimary : AppColors.border,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppText.s16W600.copyWith(
              color: isSelected ? AppColors.white : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
