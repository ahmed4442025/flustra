import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flustra_template/core/extensions/trans_extention.dart';

class NetworkToastBanner {
  static CancelFunc? _currentToast;
  static bool _isShowingBanner = false;

  /// عرض شريط انقطاع الإنترنت
  static void showNoInternetBanner() {
    if (_isShowingBanner) return;

    _currentToast = BotToast.showCustomNotification(
      toastBuilder: (context) => _buildNetworkBanner(
        message: AppStrings.noInternetConnection.tx(),
        icon: Icons.wifi_off,
        backgroundColor: const Color(0xFFD32F2F), // أحمر
        textColor: Colors.white,
      ),
      duration: null,
      // يبقى ظاهر حتى يتم إخفاءه يدوياً
      align: Alignment.topCenter,
      enableSlideOff: false,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
    );

    _isShowingBanner = true;
  }

  /// عرض شريط الإنترنت الضعيف
  static void showSlowInternetBanner() {
    if (_isShowingBanner) return;

    _currentToast = BotToast.showCustomNotification(
      toastBuilder: (context) => _buildNetworkBanner(
        message: AppStrings.weakInternetConnection.tx(),
        icon: Icons.signal_wifi_bad,
        backgroundColor: const Color(0xFFFF8F00), // برتقالي
        textColor: Colors.white,
      ),
      duration: null,
      align: Alignment.topCenter,
      enableSlideOff: false,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
    );

    _isShowingBanner = true;
  }

  /// عرض شريط استعادة الاتصال
  static void showReconnectingBanner() {
    if (_isShowingBanner) return;

    _currentToast = BotToast.showCustomNotification(
      toastBuilder: (context) => _buildNetworkBanner(
        message: AppStrings.reconnecting.tx(),
        icon: Icons.refresh,
        backgroundColor: const Color(0xFF1976D2),
        // أزرق
        textColor: Colors.white,
        showLoading: true,
      ),
      duration: null,
      align: Alignment.topCenter,
      enableSlideOff: false,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
    );

    _isShowingBanner = true;
  }

  /// عرض شريط نجح الاتصال (يختفي تلقائياً)
  static void showConnectedBanner() {
    // إخفاء أي شريط موجود أولاً
    hideBanner();

    BotToast.showCustomNotification(
      toastBuilder: (context) => _buildNetworkBanner(
        message: AppStrings.internetConnectionRestored.tx(),
        icon: Icons.wifi,
        backgroundColor: const Color(0xFF388E3C), // أخضر
        textColor: Colors.white,
      ),
      duration: const Duration(seconds: 3),
      // يختفي بعد 3 ثوانٍ
      align: Alignment.topCenter,
      enableSlideOff: true,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
    );
  }

  /// إخفاء الشريط الحالي
  static void hideBanner() {
    if (_currentToast != null && _isShowingBanner) {
      _currentToast!();
      _currentToast = null;
      _isShowingBanner = false;
    }
  }

  /// التحقق من وجود شريط معروض
  static bool get isShowingBanner => _isShowingBanner;

  /// بناء widget الشريط
  static Widget _buildNetworkBanner({
    required String message,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
    bool showLoading = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      decoration: BoxDecoration(color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showLoading)
            SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(textColor)))
          else
            Icon(icon, color: textColor, size: 15),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// إعادة تعيين حالة الكلاس (مفيد عند إعادة تشغيل التطبيق)
  static void reset() {
    _currentToast = null;
    _isShowingBanner = false;
  }
}
