import '../app_strings_localizations.dart';

const Map<String, String> enJson = {
  // ========================== 🔥 App 🔥 ==========================
  // todo : add app strings for your app

  // ========================== 🔥 Other 🔥 ==========================
  AppStrings.noMoreData: 'No more data',


// ========================== 🔥 translations label 🔥 ==========================
  AppStrings.english: 'English',
  AppStrings.arabic: 'Arabic',
  AppStrings.german: 'German',
  ..._enJsonErrorHandler,
  ..._enJsonValidators,
};

// ========================== 🔥 Validators 🔥 ==========================
const Map<String, String> _enJsonValidators = {
  AppStrings.errorEmptyField: "This field is required.",
  AppStrings.errorInvalidEmail: "Please enter a valid email address.",
  AppStrings.errorInvalidPhone: "Please enter a valid phone number.",
  AppStrings.errorPasswordTooShort: "Password must be at least 6 characters.",
  AppStrings.errorPasswordNoUppercase: "Password must contain at least one uppercase letter.",
  AppStrings.errorPasswordNoLowercase: "Password must contain at least one lowercase letter.",
  AppStrings.errorPasswordNoDigit: "Password must contain at least one digit.",
  AppStrings.errorPasswordNoSpecialChar: "Password must contain at least one special character.",
  AppStrings.errorPasswordsDoNotMatch: "Passwords do not match.",
  AppStrings.errorInvalidUsername: "Username must be 3-16 characters and alphanumeric.",
  AppStrings.errorInvalidFullName: "Please enter a valid full name.",
  AppStrings.errorInvalidUrl: "Please enter a valid URL."
};

const Map<String, dynamic> _enJsonErrorHandler = {
// ========================== 🔥 Error handler 🔥 ==========================
  AppStrings.weDidNotReceiveTheExpectedData: 'Error loading data. Could not connect to the server. Please try again later',
  AppStrings.errorConnectionTimeout: "Connection timed out. Please check your internet and try again.",
  AppStrings.errorSendTimeout: "Request timed out while sending data. Please try again.",
  AppStrings.errorReceiveTimeout: "Request timed out while waiting for response. Please try again.",
  AppStrings.errorBadCertificate: "Could not verify the server's identity. Please try again later.",
  AppStrings.errorBadResponse: "Something went wrong with the server response. Please try again later.",
  AppStrings.errorRequestCancelled: "Request was cancelled. Please try again.",
  AppStrings.errorConnection: "Connection error. Please check your network and try again.",
  AppStrings.errorUnknown: "Unexpected error occurred. Please try again later.",
// ========================== 🔥 End error handler 🔥 ==========================
};
