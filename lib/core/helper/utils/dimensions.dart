import 'dart:ui';

class Dimensions {
  static double? width;

  static void calcWidth() {
    FlutterView view = PlatformDispatcher.instance.views.first;

    double physicalWidth = view.physicalSize.width;
    double devicePixelRatio = view.devicePixelRatio;

    // Physical pixels → logical width used by Flutter
    width = physicalWidth / devicePixelRatio;
  }

  static double fontSizeExtraSmall = (width ?? 100) >= 1300 ? 12 : 10;
  static double fontSizeSmall = (width ?? 100) >= 1300 ? 14 : 12;

  static double fontSizeDefault = (width ?? 100) >= 1300 ? 16 : 14;

  static double fontSizeLarge = (width ?? 100) >= 1300 ? 18 : 16;
  static double fontSizeExtraLarge = (width ?? 100) >= 1300 ? 20 : 18;
  static double fontSizeOverLarge = (width ?? 100) >= 1300 ? 26 : 24;

  static const double paddingSizeExtraSmall = 6.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeH = 12.0;
  static const double paddingSizeDefault = 14.0;
  static const double paddingScreen = 16.0;
  static const double paddingSizeLarge = 18.0;
  static const double paddingSizeExtraLarge = 24.0;
  static const double paddingSizeOverLarge = 28.0;
  static const double paddingSizeExtraOverLarge = 40.0;

  static const double radiusExtraSmall = 6.0;
  static const double radiusSmall = 10.0;
  static const double radiusMedium = 14.0;
  static const double radiusDefault = 14.0;
  static const double radiusLarge = 18.0;
  static const double radiusExtraLarge = 24.0;
  static const double radiusPill = 999.0;

  static const double webMaxWidth = 1170;
  static const int messageInputLength = 250;
  static const double pickMapIconSize = 100.0;
  static const double maxLimitOfFileSentINConversation = 25;
  static const double maxLimitOfTotalFileSent = 5;
  static const double maxSizeOfASingleFile = 10;
  static const double maxImageSend = 10;
  static const double limitOfPickedVideoSizeInMB = 50;
}
