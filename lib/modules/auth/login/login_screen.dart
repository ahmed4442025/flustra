import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/services/app_validators.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final LoginController _controller = LoginController();

  @override
  void initState() {
    _controller.addListener(_refresh);
    _controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: ConstrainedBox(
            // لضمان أن المحتوى يمكنه التمرير حتى لو كان أقصر من الشاشة
            constraints: BoxConstraints(minHeight: screenHeight - MediaQuery.of(context).padding.top),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // يمكنك إضافة شعار هنا
                  // Image.asset('assets/logo.png', height: screenHeight * 0.15),
                  Icon(
                    Icons.lock_person_sharp, // أيقونة كمثال
                    size: screenHeight * 0.1,
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  Text(
                    'مرحباً بعودتك!',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.displayLarge.copyWith(color: AppColors.primary),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'سجل الدخول للمتابعة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // حقل البريد الإلكتروني
                  TextFormField(
                    controller: _controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'البريد الإلكتروني',
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[600]),
                    ),
                    validator: AppValidators.email,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // حقل كلمة المرور
                  TextFormField(
                    controller: _controller.passwordController,
                    obscureText: !_controller.isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'كلمة المرور',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[600]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _controller.isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: _controller.onTogglePasswordVisibility,
                      ),
                    ),
                    validator: AppValidators.passwordComplex,
                  ),
                  SizedBox(height: screenHeight * 0.015),

                  // رابط نسيت كلمة المرور
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _controller.onTapAppleLogin,
                      child: const Text('نسيت كلمة المرور؟'),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // زر تسجيل الدخول
                  _controller.isLoading
                      ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
                      : ElevatedButton(
                          onPressed: _controller.onTapLogin,
                          child: const Text('تسجيل الدخول'),
                        ),
                  SizedBox(height: screenHeight * 0.03),

                  // فاصل "أو"
                  Row(
                    children: <Widget>[
                      const Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'أو',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // أزرار تسجيل الدخول عبر الشبكات الاجتماعية (مثال)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialLoginButton(
                        icon: Icons.g_mobiledata, // استبدل بأيقونة جوجل الفعلية إذا أردت (تحتاج لحزمة مثل font_awesome_flutter)
                        color: Colors.redAccent,
                        onPressed: () {
                          // منطق تسجيل الدخول بجوجل
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تسجيل الدخول بجوجل (قيد الإنشاء)')),
                          );
                        },
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      _buildSocialLoginButton(
                        icon: Icons.apple,
                        color: Colors.black,
                        onPressed: () {
                          // منطق تسجيل الدخول بآبل
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تسجيل الدخول بآبل (قيد الإنشاء)')),
                          );
                        },
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      _buildSocialLoginButton(
                        icon: Icons.facebook,
                        color: Colors.blueAccent,
                        onPressed: () {
                          // منطق تسجيل الدخول بفيسبوك
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تسجيل الدخول بفيسبوك (قيد الإنشاء)')),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // رابط إنشاء حساب جديد
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ليس لديك حساب؟',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () {
                          // انتقل إلى شاشة إنشاء حساب
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('صفحة إنشاء حساب (قيد الإنشاء)')),
                          );
                        },
                        child: const Text(
                          'إنشاء حساب',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02), // مسافة سفلية إضافية
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[300]!, width: 1.5),
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }
}
