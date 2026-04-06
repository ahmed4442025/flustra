import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';

enum ValidationError {
  empty,
  invalidEmail,
  invalidPhone,
  passwordTooShort,
  passwordNoUppercase,
  passwordNoLowercase,
  passwordNoDigit,
  passwordNoSpecialChar,
  passwordsDoNotMatch,
  invalidUsername,
  invalidFullName,
  invalidUrl,
}

class AppValidators {
  AppValidators._();

  // --------------------------[ Configuration & Constants ]-------------------------- //

  static const int minSimplePasswordLength = 6;
  static const int minComplexPasswordLength = 8;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 15;

  static final RegExp _emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp _phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
  static final RegExp _usernameRegExp = RegExp('^[a-zA-Z][a-zA-Z0-9_]{${minUsernameLength - 1},${maxUsernameLength - 1}}\$');
  static final RegExp _urlRegExp = RegExp(r'^(https?://)?([\w\-])+\.{1}([a-zA-Z]{2,63})([/\w\-.?=&%]*)*/?$');
  static final RegExp _fullNameRegExp = RegExp(r'^[\p{L}\s]{2,}$', unicode: true);

  // Password Complexity Patterns
  static final RegExp _upperCaseRegExp = RegExp(r'[A-Z]');
  static final RegExp _lowerCaseRegExp = RegExp(r'[a-z]');
  static final RegExp _digitRegExp = RegExp(r'\d');
  static final RegExp _specialCharRegExp = RegExp(r'[!@#$&*~]');

  // --------------------------[ Validate Empty ]-------------------------- //
  static ValidationError? validateEmpty(String? value) {
    if (value == null || value.trim().isEmpty) return ValidationError.empty;
    return null;
  }

  // --------------------------[ Email Validator ]-------------------------- //
  static ValidationError? email(String? value) {
    value = value?.trim();
    if (validateEmpty(value) != null) return ValidationError.empty;

    if (!_emailRegExp.hasMatch(value!)) return ValidationError.invalidEmail;
    return null;
  }

  // --------------------------[ Phone Validator ]-------------------------- //
  static ValidationError? phone(String? value) {
    value = value?.trim();
    if (validateEmpty(value) != null) return ValidationError.empty;

    if (!_phoneRegExp.hasMatch(value!)) return ValidationError.invalidPhone;
    return null;
  }

  // --------------------------[ Simple Password Validator ]-------------------------- //
  static ValidationError? passwordSimple(String? value) {
    if (validateEmpty(value) != null) return ValidationError.empty;
    if (value!.length < minSimplePasswordLength) return ValidationError.passwordTooShort;
    return null;
  }

  // --------------------------[ Complex Password Validator ]-------------------------- //
  static List<ValidationError> passwordComplex(String? value) {
    if (validateEmpty(value) != null) return [ValidationError.empty];

    final errors = <ValidationError>[];
    if (value!.length < minComplexPasswordLength) errors.add(ValidationError.passwordTooShort);
    if (!_upperCaseRegExp.hasMatch(value)) errors.add(ValidationError.passwordNoUppercase);
    if (!_lowerCaseRegExp.hasMatch(value)) errors.add(ValidationError.passwordNoLowercase);
    if (!_digitRegExp.hasMatch(value)) errors.add(ValidationError.passwordNoDigit);
    if (!_specialCharRegExp.hasMatch(value)) errors.add(ValidationError.passwordNoSpecialChar);

    return errors;
  }

  // --------------------------[ Confirm Password Validator ]-------------------------- //
  static ValidationError? confirmPassword(String? password, String? confirmPassword) {
    if (validateEmpty(confirmPassword) != null) return ValidationError.empty;
    if (password != confirmPassword) return ValidationError.passwordsDoNotMatch;
    return null;
  }

  // --------------------------[ Username Validator ]-------------------------- //
  static ValidationError? username(String? value) {
    value = value?.trim();
    if (validateEmpty(value) != null) return ValidationError.empty;

    if (!_usernameRegExp.hasMatch(value!)) return ValidationError.invalidUsername;
    return null;
  }

  // --------------------------[ Full Name Validator ]-------------------------- //
  static ValidationError? fullName(String? value) {
    value = value?.trim();
    if (validateEmpty(value) != null) return ValidationError.empty;

    if (!_fullNameRegExp.hasMatch(value!)) return ValidationError.invalidFullName;
    return null;
  }

  // --------------------------[ URL Validator ]-------------------------- //
  static ValidationError? url(String? value) {
    if (validateEmpty(value) != null) return ValidationError.empty;

    if (!_urlRegExp.hasMatch(value!)) return ValidationError.invalidUrl;
    return null;
  }
}

extension ValidationErrorExt on ValidationError {
  String get message {
    return switch (this) {
      ValidationError.empty => AppStrings.errorEmptyField.tx(),
      ValidationError.invalidEmail => AppStrings.errorInvalidEmail.tx(),
      ValidationError.invalidPhone => AppStrings.errorInvalidPhone.tx(),
      ValidationError.passwordTooShort => AppStrings.errorPasswordTooShort.tx(),
      ValidationError.passwordNoUppercase => AppStrings.errorPasswordNoUppercase.tx(),
      ValidationError.passwordNoLowercase => AppStrings.errorPasswordNoLowercase.tx(),
      ValidationError.passwordNoDigit => AppStrings.errorPasswordNoDigit.tx(),
      ValidationError.passwordNoSpecialChar => AppStrings.errorPasswordNoSpecialChar.tx(),
      ValidationError.passwordsDoNotMatch => AppStrings.errorPasswordsDoNotMatch.tx(),
      ValidationError.invalidUsername => AppStrings.errorInvalidUsername.tx(),
      ValidationError.invalidFullName => AppStrings.errorInvalidFullName.tx(),
      ValidationError.invalidUrl => AppStrings.errorInvalidUrl.tx(),
    };
  }
}

extension ValidatorTranslator on ValidationError? Function(String?) {
  String? Function(String?) get translated =>
      (value) => this(value)?.message;
}

extension ListValidatorTranslator on List<ValidationError> Function(String?) {
  String? Function(String?) get translated => (value) {
    final errors = this(value);
    if (errors.isEmpty) return null;
    return errors.map((e) => e.message).join('\n');
  };
}
