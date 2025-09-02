abstract class AppRegex {
  static RegExp email =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  static RegExp website = RegExp(
      r"^(https?:\/\/)?(www\.)?[a-zA-Z0-9._%+-]+\.[a-zA-Z]{2,}(\/[^\s]*)?$");
  static RegExp phoneNumber = RegExp(r"^\d{10,}$");
  static RegExp atLeast8Length = RegExp(r"^.{8,}$");
  static RegExp passwordComplexity =
      RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$");
  static RegExp atLeast3Length = RegExp(r"^.{3,}$");
  static RegExp atLeast2Length = RegExp(r"^.{2,}$");
  static RegExp only5Length = RegExp(r"^.{5}$");
}
