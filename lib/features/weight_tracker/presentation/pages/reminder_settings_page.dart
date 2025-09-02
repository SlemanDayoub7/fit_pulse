import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_app/core/enums/reminder_frequency.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/reminder/reminder_bloc.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/reminder/reminder_event.dart';

class ReminderSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text("إعدادات التذكير")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: ReminderFrequency.values.map((frequency) {
            return ListTile(
              title: Text(frequencyToString(frequency),
                  style: TextStyle(color: AppColors.text)),
              onTap: () {
                context
                    .read<ReminderBloc>()
                    .add(SetReminderFrequency(frequency));
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String frequencyToString(ReminderFrequency freq) {
    switch (freq) {
      case ReminderFrequency.daily:
        return 'يوميًا';
      case ReminderFrequency.everyTwoDays:
        return 'كل يومين';
      case ReminderFrequency.weekly:
        return 'أسبوعيًا';
    }
  }
}
