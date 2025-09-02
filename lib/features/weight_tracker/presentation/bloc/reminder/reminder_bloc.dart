import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/core/enums/reminder_frequency.dart';
import 'package:gym_app/core/local_notifiaction/local_notifiaction_service.dart';

import 'package:gym_app/features/weight_tracker/presentation/bloc/reminder/reminder_event.dart';
import 'package:gym_app/features/weight_tracker/presentation/bloc/reminder/reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final NotificationService service;

  ReminderBloc(this.service)
      : super(ReminderState(frequency: ReminderFrequency.daily)) {
    on<SetReminderFrequency>((event, emit) {
      emit(ReminderState(frequency: event.frequency));
      service.scheduleReminder(event.frequency);
    });
  }
}
