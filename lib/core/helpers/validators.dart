import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

// class Validator {
//   static bool defaultValidator(String? value) => value == null || value.isEmpty;
//   static String? IBANvalidator(String value) {
//     if (value.length < 22) {
//       return LocaleKeys.iban_validate.tr();
//     } else {
//       return null;
//     }
//   }

//   static bool notNullValidator(Object? value) => value == null;
//   static String? nationalNumberValidator(String value) {
//     if (value.isEmpty) return LocaleKeys.please_add_national_number.tr();
//     // if (value.length < 10) {
//     //   return LocaleKeys.national_number_should_be_10_digits.tr();
//     // } else {
//     //   return null;
//     // }
//   }

//   static String? idNumberValidator(String value) {
//     if (value.isEmpty) return LocaleKeys.please_enter_id_number.tr();
//     // if (value.length < 10) {
//     //   return LocaleKeys.national_number_should_be_10_digits.tr();
//     // } else {
//     //   return null;
//     // }
//   }

//   static String? emailValidator(String value) {
//     if (value.isEmpty) return LocaleKeys.please_enter_email.tr();
//     Pattern pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = RegExp(pattern as String);
//     if (!regex.hasMatch(value)) {
//       return LocaleKeys.please_enter_valid_email.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? phoneNumberValidator(String value) {
//     if (value.isEmpty) return LocaleKeys.please_enter_phone_number.tr();
//     if (!value.startsWith('5')) {
//       return LocaleKeys.phone_number_must_start_with.tr();
//     }
//     return null;
//     // Pattern pattern = r'(\d{10})';
//     // RegExp regex = RegExp(pattern as String);
//     // if (!regex.hasMatch(value)) {
//     //   return LocaleKeys.please_enter_valid_phone_number.tr();
//     // } else {
//     //   return null;
//     // }
//   }

//   static String? phoneNumberValidator2(String value) {
//     if (!value.isPhone()) {
//       return LocaleKeys.please_enter_valid_phone_number.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? ageValidator(String value) {
//     if (value.isEmpty) return "required";
//     if (num.tryParse(value) == null) return "enter_valid_val";
//     if (int.parse(value) >= 150 || int.parse(value) <= 1) {
//       return 'العمر يجب ان يكون بين 1 و 150';
//     } else {
//       return null;
//     }
//   }

//   static String? hwValidator(String value) {
//     if (num.tryParse(value) == null) return "enter_valid_val";
//     if (int.parse(value) >= 350 || int.parse(value) <= 1) {
//       return 'Enter a Valid Value between 1 and 350';
//     } else {
//       return null;
//     }
//   }

//   static String? nameValidate(String value) {
//     if (value.isEmpty) return LocaleKeys.please_enter_full_name.tr();
//     // if (value.length < 2) {
//     //   FocusManager.instance.primaryFocus!.unfocus();
//     //   FocusManager.instance.primaryFocus!.requestFocus();
//     //   return 'يجب ان يكون الاسم اكثر من محرفين';
//     // } else {
//     //   return null;
//     // }
//   }

//   static bool validatePassword(String pass) {
//     RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
//     String password = pass.trim();
//     if (passValid.hasMatch(password)) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   static String? newPasswordValidate(String newPassword, String oldPassword,
//       {String? message}) {
//     if (newPassword.isEmpty) {
//       return message ?? LocaleKeys.please_enter_password.tr();
//     }
//     if (newPassword == oldPassword) {
//       return LocaleKeys.new_password_must_be_different.tr();
//     }
//     if (newPassword.length < 6) {
//       FocusManager.instance.primaryFocus!.unfocus();
//       FocusManager.instance.primaryFocus!.requestFocus();
//       return LocaleKeys.password_length.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? passwordValidate(String value, {String? message}) {
//     if (value.isEmpty) return message ?? LocaleKeys.please_enter_password.tr();
//     if (value.length < 6) {
//       FocusManager.instance.primaryFocus!.unfocus();
//       FocusManager.instance.primaryFocus!.requestFocus();
//       return LocaleKeys.password_length.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? confirmPasswordValidate(String value, String value2) {
//     if (value != value2) {
//       return LocaleKeys.passwords_do_not_match.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? pinCodeValidate(String value) {
//     if (value.length < 4) {
//       FocusManager.instance.primaryFocus!.unfocus();
//       FocusManager.instance.primaryFocus!.requestFocus();
//       return LocaleKeys.please_complete_pincode.tr();
//     }
//     return null;
//   }

//   static String? requestDescriptionValidate(String value, context) {
//     if (value.length < 20) {
//       FocusManager.instance.primaryFocus!.unfocus();
//       FocusManager.instance.primaryFocus!.requestFocus();
//       return "text_too_small".tr();
//     }
//     if (value.length > 170) {
//       FocusManager.instance.primaryFocus!.unfocus();
//       FocusManager.instance.primaryFocus!.requestFocus();
//       return "text_too_large".tr();
//     } else {
//       return null;
//     }
//   }
// }
class Validator {
  static String? validateNumber(String? value, {required String fieldName}) {
    if (value == null || value.isEmpty) return '$fieldName is required';
    final number = double.tryParse(value);
    if (number == null) return 'Invalid number format';
    if (number <= 0) return '$fieldName must be positive';
    return null;
  }

  static bool defaultValidator(String? value) => value == null || value.isEmpty;

  static String? IBANvalidator(String value) {
    if (value.length < 22) {
      return "رقم الآيبان يجب أن يتكون من 22 رقمًا على الأقل";
    } else {
      return null;
    }
  }

  static bool notNullValidator(Object? value) => value == null;

  static String? nationalNumberValidator(String value) {
    if (value.isEmpty) return "يرجى إدخال الرقم الوطني";
    // يمكنك إلغاء التعليق للتحقق من الطول مثلاً
    // if (value.length < 10) return "الرقم الوطني يجب أن يتكون من 10 أرقام";
  }

  static String? idNumberValidator(String value) {
    if (value.isEmpty) return "يرجى إدخال رقم الهوية";
    // if (value.length < 10) return "رقم الهوية يجب أن يتكون من 10 أرقام";
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) return "يرجى إدخال البريد الإلكتروني";
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return "يرجى إدخال بريد إلكتروني صحيح";
    } else {
      return null;
    }
  }

  static String? phoneNumberValidator(String value) {
    if (value.isEmpty) return "يرجى إدخال رقم الجوال";
    if (!value.startsWith('5')) {
      return "رقم الجوال يجب أن يبدأ بـ 5";
    }
    return null;
  }

  static String? phoneNumberValidator2(String value) {
    if (!value.isPhone()) {
      return "يرجى إدخال رقم جوال صحيح";
    } else {
      return null;
    }
  }

  static String? ageValidator(String value) {
    if (value.isEmpty) return "الحقل مطلوب";
    if (num.tryParse(value) == null) return "يرجى إدخال قيمة صحيحة";
    if (int.parse(value) >= 150 || int.parse(value) <= 1) {
      return 'العمر يجب أن يكون بين 1 و 150';
    } else {
      return null;
    }
  }

  static String? hwValidator(String value) {
    if (num.tryParse(value) == null) return "يرجى إدخال قيمة صحيحة";
    if (int.parse(value) >= 350 || int.parse(value) <= 1) {
      return 'أدخل قيمة صحيحة بين 1 و 350';
    } else {
      return null;
    }
  }

  static String? nameValidate(String value) {
    if (value.isEmpty) return "يرجى إدخال الاسم الكامل";
    // if (value.length < 2) return "الاسم يجب أن يتكون من أكثر من محرفين";
  }

  static bool validatePassword(String pass) {
    RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    String password = pass.trim();
    return passValid.hasMatch(password);
  }

  static String? newPasswordValidate(String newPassword, String oldPassword,
      {String? message}) {
    if (newPassword.isEmpty) {
      return message ?? "يرجى إدخال كلمة المرور";
    }
    if (newPassword == oldPassword) {
      return "كلمة المرور الجديدة يجب أن تكون مختلفة عن الحالية";
    }
    if (newPassword.length < 6) {
      FocusManager.instance.primaryFocus!.unfocus();
      FocusManager.instance.primaryFocus!.requestFocus();
      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    } else {
      return null;
    }
  }

  static String? passwordValidate(String value, {String? message}) {
    if (value.isEmpty) return message ?? "يرجى إدخال كلمة المرور";

    if (value.length < 8) {
      FocusManager.instance.primaryFocus?.unfocus();
      FocusManager.instance.primaryFocus?.requestFocus();
      return "كلمة المرور يجب أن تكون 8 محارف على الأقل";
    }

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    final hasSpecialChar = RegExp(r'[^\w\s]').hasMatch(value);

    if (!hasLetter || !hasDigit || !hasSpecialChar) {
      return "كلمة المرور يجب أن تحتوي على أحرف وأرقام ورموز";
    }

    return null;
  }

  static String? confirmPasswordValidate(String value, String value2) {
    if (value != value2) {
      return "كلمتا المرور غير متطابقتين";
    } else {
      return null;
    }
  }

  static String? pinCodeValidate(String value) {
    if (value.length < 4) {
      FocusManager.instance.primaryFocus!.unfocus();
      FocusManager.instance.primaryFocus!.requestFocus();
      return "يرجى إكمال رمز التحقق";
    }
    return null;
  }

  static String? requestDescriptionValidate(String value, context) {
    if (value.length < 20) {
      FocusManager.instance.primaryFocus!.unfocus();
      FocusManager.instance.primaryFocus!.requestFocus();
      return "النص قصير جدًا، يرجى التوضيح أكثر";
    }
    if (value.length > 170) {
      FocusManager.instance.primaryFocus!.unfocus();
      FocusManager.instance.primaryFocus!.requestFocus();
      return "النص طويل جدًا، يرجى الاختصار";
    } else {
      return null;
    }
  }

  static String? firstNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال الاسم الأول";
    }
    if (value.trim().length < 2) {
      return "الاسم الأول يجب أن يكون على الأقل محرفين";
    }
    return null;
  }

  static String? lastNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال اسم العائلة";
    }
    if (value.trim().length < 2) {
      return "اسم العائلة يجب أن يكون على الأقل محرفين";
    }
    return null;
  }

  static String? userValidator(String? value) {
    // Assuming this is email
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال البريد الإلكتروني";
    }
    return emailValidator(value.trim());
  }

  static String? weightValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال الوزن";
    }
    final numVal = double.tryParse(value);
    if (numVal == null) {
      return "يرجى إدخال قيمة رقمية صحيحة للوزن";
    }
    if (numVal <= 0 || numVal > 500) {
      return "الوزن يجب أن يكون بين 1 و 500 كجم";
    }
    return null;
  }

  static String? goalWeightValidator(String? value) {
    // Same rules as weight
    return weightValidator(value);
  }

  static String? heightValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال الطول";
    }
    final numVal = double.tryParse(value);
    if (numVal == null) {
      return "يرجى إدخال قيمة رقمية صحيحة للطول";
    }
    if (numVal <= 0 || numVal > 300) {
      return "الطول يجب أن يكون بين 1 و 300 سم";
    }
    return null;
  }

  static String? birthDateValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال تاريخ الميلاد";
    }
    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();
      if (date.isAfter(now)) {
        return "تاريخ الميلاد لا يمكن أن يكون في المستقبل";
      }
      if (now.year - date.year > 150) {
        return "تاريخ الميلاد غير معقول";
      }
    } catch (_) {
      return "يرجى إدخال تاريخ صحيح (YYYY-MM-DD)";
    }
    return null;
  }

  static String? fitnessLevelValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال مستوى اللياقة";
    }
    return null;
  }

  static String? fitnessGoalValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال هدف اللياقة";
    }
    return null;
  }

  static String? certificationValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال الشهادة";
    }
    return null;
  }

  static String? yearsOfExperienceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال سنوات الخبرة";
    }
    final intVal = int.tryParse(value);
    if (intVal == null) {
      return "يرجى إدخال عدد صحيح لسنوات الخبرة";
    }
    if (intVal < 0 || intVal > 100) {
      return "سنوات الخبرة يجب أن تكون بين 0 و 100";
    }
    return null;
  }
}
