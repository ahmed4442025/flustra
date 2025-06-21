import 'package:flustra_template/core/services/app_snake_bar.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  // ========================== Constructor ==========================
  LoginController();

  // ========================== 🔒 Private variables 🔒 ==========================
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // ========================== 🗝️ Public variables 🗝️ ==========================
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isPasswordVisible => _isPasswordVisible;

  bool get isLoading => _isLoading;

  // ========================== 🔥 initialization 🔥 ==========================
  void init() {}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ========================== 🌍 Public methods and events 🌍 ==========================
  void onTogglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void onForgotPassword() {
    // TODO: Implement forgot password logic
    print("Forgot Password tapped");
  }

  void onTapLogin() async {
    // if (!formKey.currentState!.validate()) return;
    _setLoading(true);

    await Future.delayed(const Duration(seconds: 2));
    _setLoading(false);

    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");

    AppSnackBar.show('تم تسجيل الدخول بنجاح (محاكاة)!', type: ToastType.success);

    // بعد تسجيل الدخول بنجاح، انتقل إلى الشاشة الرئيسية
  }

  void onTapGoogleLogin() {
    // TODO: Implement Google login logic
    print("Google Login tapped");
  }

  void onTapAppleLogin() {
    // TODO: Implement Apple login logic
    print("Apple Login tapped");
  }

  void onTapForgetPassword() {
    AppSnackBar.show("صفحة استعادة كلمة المرور (قيد الإنشاء)", type: ToastType.info);
    // TODO: Implement Apple login logic
    print("Apple Login tapped");
  }

  void onTapFacebookLogin() {
    // TODO: Implement Facebook login logic
    print("Facebook Login tapped");
  }

  void onTapSignUp() {
    // TODO: Navigate to sign up screen
    print("Sign Up tapped");
  }

  // ========================== 🔒 Private methods 🔒 ==========================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
