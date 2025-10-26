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

  AppStrings.noInternetConnection: 'No internet connection',
  AppStrings.weakInternetConnection: 'Weak internet connection',
  AppStrings.reconnecting: 'Reconnecting...',
  AppStrings.internetConnectionRestored: 'Internet connection restored',
  AppStrings.noInternet: 'No internet',
  AppStrings.connected: 'Connected',

  ..._enJsonErrorHandler,
  ..._enJsonValidators,
};

// ========================== 🔥 Validators 🔥 ==========================
const Map<String, String> _enJsonValidators = {
  AppStrings.errorEmptyField: "This field can't be empty.",
  AppStrings.errorInvalidEmail: "Please enter a valid email.",
  AppStrings.errorInvalidPhone: "Enter a valid phone number.",
  AppStrings.errorPasswordTooShort: "Use at least 6 characters.",
  AppStrings.errorPasswordNoUppercase: "Add at least one capital letter.",
  AppStrings.errorPasswordNoLowercase: "Add at least one lowercase letter.",
  AppStrings.errorPasswordNoDigit: "Include at least one number.",
  AppStrings.errorPasswordNoSpecialChar: "Add one special character (e.g. !@#).",
  AppStrings.errorPasswordsDoNotMatch: "Passwords don’t match.",
  AppStrings.errorInvalidUsername: "Username must be 3–16 characters, start with a letter, and use only letters, numbers, or underscores.",
  AppStrings.errorInvalidFullName: "Enter valid name",
  AppStrings.errorInvalidUrl: "Enter a valid link (URL).",
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

