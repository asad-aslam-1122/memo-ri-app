import 'localization/app_localization.dart';

class AppValidator {
  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_email_address".L();
    }
    if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return "invalid_email_address".L();
    }
    if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value)) {
      return "invalid_email_address".L();
    }
    return null;
  }

  static String? validateLoginPassword(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_password".L();
    }
    if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return "please_enter_your_password".L();
    }
    if (value.length < 6) {
      return "password_consists_minimum_6_character".L();
    }
    return null;
  }

  static String? validateOTP(String? value) {
    if (value!.isEmpty) return "please_enter_the_otp".L();
    if (value.length < 6) {
      return "invalid_otp".L();
    }
    return null;
  }

  static String? validateNewPassword(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_new_password".L();
    }
    if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return "please_enter_your_new_password".L();
    }
    if (value.length < 6) {
      return "new_password_consists_minimum_6_character".L();
    }
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return "new_password_should_include_1_number".L();
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
      return "new_password_should_include_1_special_character".L();
    }
    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
      return "new_password_should_include_1_uppercase_character".L();
    }
    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
      return "new_password_should_include_1_lowercase_character".L();
    }
    return null;
  }

  static String? validatePasswordMatch(String? value, String? pass2) {
    if (value!.isEmpty) {
      return "please_re_enter_your_password".L();
    }
    if (value != pass2) {
      return "password_did_not_match".L();
    }
    return null;
  }

  static String? validateFullName(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_name".L();
    }

    if (!RegExp(r'^[a-zA-Z]+( [a-zA-Z]+)*$').hasMatch(value)) {
      return "invalid_full_name".L();
    }
    return null;
  }

  static String? validateTitleName(String? value) {
    if (value!.isEmpty) {
      return "please_enter_title_name".L();
    }
    return null;
  }

  static String? validateCateName(String? value) {
    if (value!.isEmpty) {
      return "please_enter_category_name".L();
    }
    return null;
  }

  static String? validateAlbumName(String? value) {
    if (value!.isEmpty) {
      return "please_enter_album_name".L();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "please_enter_your_password".L();
    }
    if (!RegExp(r'^[^\s]').hasMatch(value)) {
      return "please_enter_your_password".L();
    }
    if (value.length < 6) {
      return "password_consists_minimum_6_character".L();
    }
    if (!RegExp(r"^(?=.*?[0-9])").hasMatch(value)) {
      return "password_should_include_1_number".L();
    }
    if (!RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value.trim())) {
      return "password_should_include_1_special_character".L();
    }
    if (!RegExp(r'^(?=.*?[A-Z])').hasMatch(value)) {
      return "password_should_include_1_uppercase_character".L();
    }
    if (!RegExp(r'^(?=.*?[a-z])').hasMatch(value)) {
      return "password_should_include_1_lowercase_character".L();
    }
    return null;
  }

  static String? validateEmpty(String? value) {
    if (value!.isEmpty) {
      return "field_required".L();
    }
    return null;
  }

  static String? validateLicense(String? value) {
    if (value!.isEmpty) {
      return "field_required".L();
    }
    if (value.length > 10) {
      return "licence_number_exceeds_maximum_length".L();
    }
    return null;
  }

  static String? validateDeviceCode(String? value) {
    if (value!.isEmpty) {
      return "device_code_required".L();
    }
    return null;
  }

  static String? validateDropdown(value) {
    if (value == null) {
      return "field_required".L();
    }
    return null;
  }

  static String? validateDOB(String? value) {
    if (value!.isEmpty) {
      return "please_select_your_date_of_birth".L();
    }
    return null;
  }
}
