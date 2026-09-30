class Validators {
  Validators._();

  static final _emailRegex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');

  // أرقام الموبايل المصرية: 010/011/012/015 وبعدها 8 أرقام.
  static final _egyptPhoneRegex = RegExp(r'^01[0125][0-9]{8}$');

  static bool isValidEmail(String value) => _emailRegex.hasMatch(value.trim());

  static bool isValidEgyptPhone(String value) =>
      _egyptPhoneRegex.hasMatch(value.trim());

  static bool isValidPassword(String value) => value.trim().length >= 6;
}
