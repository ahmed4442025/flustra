import 'package:dio/dio.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';
import 'package:flustra_template/core/services/app_session_manager.dart';
import 'package:flustra_template/core/services/app_snake_bar.dart';
import 'package:flustra_template/core/services/console_printer.dart';
import 'package:flustra_template/modules/home_with_navigation_bar/views/home_navigation_bar/home_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../cubit/auth_cubit.dart';
import '../data/requests/login_request.dart';
import '../data/responses/login_response.dart';

class LoginController extends ChangeNotifier {
  // ========================== Constructor ========================== //
  LoginController(this._authCubit);

  // ========================== 🔒 Private variables 🔒 ========================== //
  final AuthCubit _authCubit;
  final CancelToken _cancel = CancelToken();
  final String loginState = UniqueKey().toString();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // ========================== 🗝️ Public getters 🗝️ ========================== //
  bool get isPasswordVisible => _isPasswordVisible;

  bool get isLoading => _isLoading;

  // ========================== 🔥 initialization 🔥 ========================== //
  void init() {
    if (kDebugMode) {
      emailController.text = "";
      passwordController.text = "";
    }
  }

  // ========================== 🌍 Public events 🌍 ========================== //

  // --------------------------[ onTogglePasswordVisibility ]-------------------------- //
  void onTogglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // --------------------------[ onTapLogin ]-------------------------- //
  void onTapLogin() {
    final mockResponse = _getFakeLoginResponse();
    AppSessionManager.updateUser(mockResponse);
    HomeScreenWithNavigationBar.navigateToMe(HomeScreenWithNavigationBarData(initialPage: MainScreenPageType.home));
    // if (formKey.currentState?.validate() ?? false) _login();
  }

  // --------------------------[ onTapForgetPassword ]-------------------------- //
  void onTapForgetPassword() {
    AppSnackBar.show("صفحة استعادة كلمة المرور (قيد الإنشاء)", type: ToastType.info);
    "Forgot Password tapped".printWithColor();
  }

  // --------------------------[ onTapGoogleLogin ]-------------------------- //
  void onTapGoogleLogin() {
    "Google Login tapped".printWithColor();
  }

  // --------------------------[ onTapAppleLogin ]-------------------------- //
  void onTapAppleLogin() {
    "Apple Login tapped".printWithColor();
  }

  // --------------------------[ onTapFacebookLogin ]-------------------------- //
  void onTapFacebookLogin() {
    "Facebook Login tapped".printWithColor();
  }

  // --------------------------[ onTapSignUp ]-------------------------- //
  void onTapSignUp() {
    "Sign Up tapped".printWithColor();
  }

  // ========================== 🔒 Private methods 🔒 ========================== //

  // --------------------------[ _login ]-------------------------- //
  Future<void> _login() async {
    _setLoading(true);
    final res = await _authCubit.login(
      loginRequest: LoginRequest(companyEmail: "admin@gmail.com", username: emailController.text.trim(), password: passwordController.text),
      cancelToken: _cancel,
      state: loginState,
    );
    _setLoading(false);
    res.fold((Failure f) => f.showToast(), (LoginResponse model) {
      if (model.data != null) {
        AppSessionManager.updateUser(model);
        HomeScreenWithNavigationBar.navigateToMe(HomeScreenWithNavigationBarData(initialPage: MainScreenPageType.home));
      }
    });
  }

  // --------------------------[ _getFakeLoginResponse ]-------------------------- //
  LoginResponse _getFakeLoginResponse() {
    return LoginResponse(
      status: true,
      message: 'Success',
      data: UserDataResponse(
        token: 'mock_token',
        user: UserResponse(id: 1, name: 'Agent Name', email: emailController.text.trim()),
      ),
    );
  }

  // --------------------------[ _setLoading ]-------------------------- //
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _cancel.cancel();
    _authCubit.disposeState(loginState);
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
