import 'package:easy_localization/easy_localization.dart';

import '../constants/app_constants.dart';

String localizedText({
  required String? en,
  required String? ar,
}) {
  String currentLanguage = getCurrentLanguage();

  bool isArabic = currentLanguage == 'ar';
  if (ar != null && en != null) {
    return isArabic ? ar : en;
  } else if (ar != null) {
    return ar;
  } else if (en != null) {
    return en;
  }
  return '';
}

String getCurrentLanguage() {
  return 'ar';
  // return EasyLocalization.of(AppConstants.navigatorKey.currentContext!)
  //         ?.locale
  //         .languageCode ??
  //     'en';
}
