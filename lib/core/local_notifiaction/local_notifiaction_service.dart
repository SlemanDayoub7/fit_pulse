import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gym_app/core/enums/reminder_frequency.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GlobalKey<NavigatorState> navigatorKey;

  NotificationService({required this.navigatorKey});

  Future<void> init() async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleNotificationTap(response.payload);
      },
    );

    // if (kDebugMode) {
    _startDebugReminderEveryMinute();
    // }
  }

  Future<void> scheduleReminder(ReminderFrequency frequency) async {
    await _notificationsPlugin.cancelAll();

    final interval = _getInterval(frequency);
    final scheduledDate = _nextInstance(interval);

    await _notificationsPlugin.zonedSchedule(
      0,
      'تذكير الوزن',
      'لا تنسَ إدخال وزنك اليوم!',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weight_channel',
          'Weight Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'weight_entry', // ✅ تحديد الوجهة عند الضغط
    );
  }

  Duration _getInterval(ReminderFrequency frequency) {
    switch (frequency) {
      case ReminderFrequency.daily:
        return Duration(days: 1);
      case ReminderFrequency.everyTwoDays:
        return Duration(days: 2);
      case ReminderFrequency.weekly:
        return Duration(days: 7);
    }
  }

  tz.TZDateTime _nextInstance(Duration interval) {
    final now = tz.TZDateTime.now(tz.local);
    final target =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 9); // 9 صباحًا
    return now.isAfter(target) ? target.add(interval) : target;
  }

  void _handleNotificationTap(String? payload) {
    if (payload == 'weight_entry') {
      navigatorKey.currentState?.pushNamed('/weight-entry');
    }
  }

  void _startDebugReminderEveryMinute() {
    Timer.periodic(Duration(minutes: 1), (_) {
      _notificationsPlugin.show(
        999,
        'تذكير تجريبي',
        'كل دقيقة - للتجريب فقط',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'debug_channel',
            'Debug Channel',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        payload: 'weight_entry', // حتى بالإشعار التجريبي يروح عالصفحة
      );
    });
  }
}
