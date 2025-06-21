class ErrorCodes {
  /// General/default errors
  static const int defaultError = -1;
  static const int unknown = -2;

  /// Dio/network errors
  static const int connectTimeout = -10;
  static const int sendTimeout = -11;
  static const int receiveTimeout = -12;
  static const int badCertificate = -15;
  static const int badResponse = -16;
  static const int cancel = -13;
  static const int connectionError = -14;

  /// HTTP-specific mapped responses (optional if needed)
  static const int authError = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;
}
