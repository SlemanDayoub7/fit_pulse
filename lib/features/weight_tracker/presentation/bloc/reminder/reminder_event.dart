import 'package:gym_app/core/enums/reminder_frequency.dart';

abstract class ReminderEvent {}

class SetReminderFrequency extends ReminderEvent {
  final ReminderFrequency frequency;

  SetReminderFrequency(this.frequency);
}
