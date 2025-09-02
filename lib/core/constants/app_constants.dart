import 'package:flutter/widgets.dart';

abstract class AppConstants {
  static final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

  static final navigatorKey = GlobalKey<NavigatorState>();

  ///Path
  static const String translationsFolderPath = 'assets/locales';
  static const String mainFont = "NotoKufiArabic";
  static const String nativeNotificationIcon = "@mipmap/ic_notification";
  static const String channelName = "channel name";
  static const String channelDescription = "channel description";
  static const String body = "Body";
  static const String en = "en";
  static const String ar = "ar";

  /// For date format
  static const String slashDateFormat = "MM/dd/yyyy";
  static const String dashDateFormat = "dd-MM-yyyy";
  static const String defaultFormat = "yyyy/M/d";
  static const String defaultTimeFormat = "hh:mm a";

  /// for http manage
  static const String data = "data";
  static const String succeeded = "succeeded";
  static const String types = "types";

  static const int count = 10;
}
