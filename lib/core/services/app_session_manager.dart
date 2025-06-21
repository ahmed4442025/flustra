import 'package:pripo/core/data/cache/cache_key.dart';
import 'package:pripo/modules/auth/data/responses/login_response.dart';

class AppSessionManager {
  AppSessionManager._();

  static LoginResponse? _user;

  static User? get user => _user?.user;

  static bool get amILogin => user?.token?.isNotEmpty ?? false;

  static void updateUserToken(String token) {
    _user?.user?.token = token;
    updateUser(_user);
  }

  /// pass null that mean user will removes
  static void updateUser(LoginResponse? loginResponse) {
    _user = loginResponse;

    if (loginResponse == null) {
      AppCache.remove(key: CacheKey.loginResponse);
      return;
    }

    AppCache.saveData(key: CacheKey.loginResponse, value: _user?.toJson());
  }

  static void init() {
    var res = AppCache.getMap(key: CacheKey.loginResponse);
    if (res == null) return;
    _user = LoginResponse.fromJson(res);
  }
}
