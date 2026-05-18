abstract class ApiConstants {
  // TODO: Put your actual URL here
  static const String baseUrl = "https://placeholder-api.example.com/api/v1";

  static final _AuthApi auth = _AuthApi();
}

class _AuthApi {
  final String login = "/agent/auth/login";
}
