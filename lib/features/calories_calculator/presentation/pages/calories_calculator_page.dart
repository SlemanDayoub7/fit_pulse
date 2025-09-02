import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/helpers/validators.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/core/widgets/custom_text_field.dart';
import 'package:gym_app/features/calories_calculator/domain/entites/gender.dart';

import '../../domain/usecases/calculate_calories_usecase.dart';
import '../bloc/calories_calculator_bloc.dart';
import '../bloc/calories_calculator_event.dart';
import '../bloc/calories_calculator_state.dart';

class CaloriesCalculatorPage extends StatelessWidget {
  const CaloriesCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: Text('Calories Calculator', style: AppText.heading),
      ),
      body: BlocProvider(
        create: (_) => CaloriesCalculatorBloc(),
        child: const _CalculatorForm(),
      ),
    );
  }
}

class _CalculatorForm extends StatefulWidget {
  const _CalculatorForm();

  @override
  State<_CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends State<_CalculatorForm> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaloriesCalculatorBloc>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _GenderSelector(),
            SizedBox(height: 20.h),
            CustomTextField(
              controller: _ageController,
              hintText: 'Age ',
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              controller: _weightController,
              hintText: 'Weight (kg)',
              keyboardType: TextInputType.number,
              validator: (v) =>
                  Validator.validateNumber(v, fieldName: 'Weight'),
            ),
            SizedBox(height: 15.h),
            CustomTextField(
              controller: _heightController,
              hintText: 'Height (cm)',
              keyboardType: TextInputType.number,
              validator: (v) =>
                  Validator.validateNumber(v, fieldName: 'Height'),
            ),
            SizedBox(height: 20.h),
            _ActivityLevelDropdown(),
            SizedBox(height: 30.h),
            BlocConsumer<CaloriesCalculatorBloc, CaloriesCalculatorState>(
              listener: (context, state) {
                if (state.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error!)),
                  );
                }
              },
              builder: (context, state) {
                return AppButton(
                  title:
                      state.isLoading ? 'Calculating...' : 'Calculate Calories',
                  enabled: !state.isLoading,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      bloc.add(CalculateCaloriesEvent(
                        age: int.parse(_ageController.text),
                        weight: double.parse(_weightController.text),
                        height: double.parse(_heightController.text),
                      ));
                    }
                  },
                );
              },
            ),
            SizedBox(height: 30.h),

            // --- ANIMATED RESULT BOX ---
            BlocBuilder<CaloriesCalculatorBloc, CaloriesCalculatorState>(
              builder: (context, state) {
                return AnimatedSwitcher(
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
                  child: state.calories == null
                      ? const SizedBox.shrink()
                      : Container(
                          key: ValueKey(state.calories), // Important!
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppColors.nutritionPrimary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Text(
                            'Your daily calorie need is:\n${state.calories!.toStringAsFixed(0)} kcal',
                            textAlign: TextAlign.center,
                            style: AppText.s20W600
                                .copyWith(color: AppColors.nutritionPrimary),
                          ),
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GenderSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaloriesCalculatorBloc>();
    return BlocBuilder<CaloriesCalculatorBloc, CaloriesCalculatorState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _GenderRadio(
              label: 'Male',
              gender: Gender.male,
              selectedGender: state.gender,
              onChanged: (g) => bloc.add(GenderChanged(g)),
            ),
            SizedBox(width: 40.w),
            _GenderRadio(
              label: 'Female',
              gender: Gender.female,
              selectedGender: state.gender,
              onChanged: (g) => bloc.add(GenderChanged(g)),
            ),
          ],
        );
      },
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

class _ActivityLevelDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CaloriesCalculatorBloc>();
    return BlocBuilder<CaloriesCalculatorBloc, CaloriesCalculatorState>(
      builder: (context, state) {
        return Container(
          width: 340.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: BoxDecoration(
            color: AppColors.offPrimary,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ActivityLevel>(
              value: state.activityLevel,
              isExpanded: true,
              items: ActivityLevel.values.map((level) {
                return DropdownMenuItem<ActivityLevel>(
                  value: level,
                  child: Text(
                    _activityLevelLabel(level),
                    style: AppText.s14w400,
                  ),
                );
              }).toList(),
              onChanged: (level) {
                if (level != null) {
                  bloc.add(ActivityLevelChanged(level));
                }
              },
            ),
          ),
        );
      },
    );
  }

  String _activityLevelLabel(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary:
        return 'Sedentary (little or no exercise)';
      case ActivityLevel.lightlyActive:
        return 'Lightly Active (light exercise 1-3 days/week)';
      case ActivityLevel.moderatelyActive:
        return 'Moderately Active (moderate exercise 3-5 days/week)';
      case ActivityLevel.veryActive:
        return 'Very Active (hard exercise 6-7 days/week)';
      case ActivityLevel.extraActive:
        return 'Extra Active (very hard exercise & physical job)';
    }
  }
}
