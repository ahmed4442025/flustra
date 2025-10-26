import 'package:flustra_template/core/extensions/trans_extention.dart';

import '../localization/app_strings_localizations.dart';

class AppValidators {
  AppValidators._();

  static String? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.errorEmptyField.tx();
    }
    return null;
  }

  // ========================== 🔥 Email Address 🔥 ==========================
  static String? email(String? value) {
    value = value?.trim();
    final emptyCheck = validateEmpty(value);
    if (emptyCheck != null) return emptyCheck;

    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value!)) {
      return AppStrings.errorInvalidEmail.tx();
    }
    return null;
  }

  // ========================== 🔥 Phone Number 🔥 ==========================
  static String? phone(String? value) {
    value = value?.trim();
    final emptyCheck = validateEmpty(value);
    if (emptyCheck != null) return emptyCheck;

    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(value!)) {
      return AppStrings.errorInvalidPhone.tx();
    }
    return null;
  }

  // ========================== 🔥 Password Simple 🔥 ==========================
  static String? passwordSimple(String? value) {
    final emptyCheck = validateEmpty(value);
    if (emptyCheck != null) return emptyCheck;

    if (value!.length < 6) {
      return AppStrings.errorPasswordTooShort.tx();
    }
    return null;
  }

  // ========================== 🔥 Password Complex 🔥 ==========================
  static String? passwordComplex(String? value) {
    final emptyCheck = validateEmpty(value);
    if (emptyCheck != null) return emptyCheck;

    final errors = <String>[];

    if (value!.length < 8) {
      errors.add(AppStrings.errorPasswordTooShort.tx());
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      errors.add(AppStrings.errorPasswordNoUppercase.tx());
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      errors.add(AppStrings.errorPasswordNoLowercase.tx());
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      errors.add(AppStrings.errorPasswordNoDigit.tx());
    }
    if (!RegExp(r'[!@#$&*~]').hasMatch(value)) {
      errors.add(AppStrings.errorPasswordNoSpecialChar.tx());
    }

    if (errors.isNotEmpty) {
      return errors.join('\n');
    }
    return null;
  }

  // ========================== 🔥 Confirm Password 🔥 ==========================
  static String? confirmPassword(String? password, String? confirmPassword) {
    final emptyCheck = validateEmpty(confirmPassword);
    if (emptyCheck != null) return emptyCheck;

    if (password != confirmPassword) {
      return AppStrings.errorPasswordsDoNotMatch.tx();
    }
    return null;
  }

  // ========================== 🔥 Username 🔥 ==========================
  static String? username(String? value) {
    value = value?.trim();
    final emptyCheck = validateEmpty(value);
    if (emptyCheck != null) return emptyCheck;

    final usernameRegex = RegExp(r'^[a-zA-Z][a-zA-Z0-9_]{2,15}$');
    if (!usernameRegex.hasMatch(value!)) {
      return AppStrings.errorInvalidUsername.tx();
    }
    return null;
  }

  // ========================== 🔥 Full Name 🔥 ==========================
  static String? fullName(String? value) {
    value = value?.trim();
    final emptyCheck = validateEmpty(value);
    if (emptyCheck != null) return emptyCheck;

    final nameRegex = RegExp(r'^[\p{L}\s]{2,}$', unicode: true);
    if (!nameRegex.hasMatch(value!)) {
      return AppStrings.errorInvalidFullName.tx();
    }
    return null;
  }

  // ========================== 🔥 URL / Website 🔥 ==========================
  static String? url(String? value) {
    final emptyCheck = validateEmpty(value);
    if (emptyCheck != null) return emptyCheck;

    final urlRegex = RegExp(r'^(https?://)?([\w\-])+\.{1}([a-zA-Z]{2,63})([/\w\-.?=&%]*)*/?$');
    if (!urlRegex.hasMatch(value!)) {
      return AppStrings.errorInvalidUrl.tx();
    }
    return null;
  }
}
