import '../app_strings_localizations.dart';

const Map<String, String> arJson = {
  // ========================== 🔥 App 🔥 ==========================
  // todo : add app strings for your app

  // ========================== 🔥 Other 🔥 ==========================
  AppStrings.noMoreData: 'لا توجد بيانات أخرى',

  AppStrings.noInternetConnection: 'لا يوجد اتصال بالإنترنت',
  AppStrings.weakInternetConnection: 'اتصال إنترنت ضعيف',
  AppStrings.reconnecting: 'إعادة الاتصال...',
  AppStrings.internetConnectionRestored: 'تم استعادة الاتصال بالإنترنت',
  AppStrings.noInternet: 'لا يوجد اتصال بالإنترنت',
  AppStrings.connected: 'متصل',

  ..._arJsonLanguage,
  ..._arJsonValidators,
  ..._enJsonErrorHandler,
};

const Map<String, dynamic> _arJsonLanguage = {
  // ========================== 🔥 translations label 🔥 ==========================
  AppStrings.english: 'الانجليزية',
  AppStrings.arabic: 'العربية',
  AppStrings.german: 'الألمانية',
};

const Map<String, dynamic> _enJsonErrorHandler = {
// ========================== 🔥 Error handler 🔥 ==========================
  AppStrings.weDidNotReceiveTheExpectedData: 'خطأ في تحميل البيانات. تعذر الاتصال بالخادم. يرجى المحاولة مرة أخرى لاحقًا.',
  AppStrings.errorConnectionTimeout: "انتهت مهلة الاتصال. تحقق من الإنترنت وحاول مرة أخرى.",
  AppStrings.errorSendTimeout: "انتهت مهلة الطلب أثناء إرسال البيانات. حاول مرة أخرى.",
  AppStrings.errorReceiveTimeout: "انتهت مهلة الطلب أثناء انتظار الاستجابة. حاول مرة أخرى.",
  AppStrings.errorBadCertificate: "تعذر التحقق من هوية الخادم. حاول لاحقاً.",
  AppStrings.errorBadResponse: "حدث خطأ في استجابة الخادم. حاول لاحقاً.",
  AppStrings.errorRequestCancelled: "تم إلغاء الطلب. حاول مرة أخرى.",
  AppStrings.errorConnection: "خطأ في الاتصال. تحقق من الشبكة وحاول مجددًا.",
  AppStrings.errorUnknown: "حدث خطأ غير متوقع. حاول مرة أخرى لاحقاً.",
// ========================== 🔥 End error handler 🔥 ==========================
};

const Map<String, String> _arJsonValidators = {
  // ========================== 🔥 Validations 🔥 ==========================
  AppStrings.errorEmptyField: 'هذا الحقل لا يمكن أن يكون فارغًا.',
  AppStrings.errorInvalidEmail: 'يرجى إدخال بريد إلكتروني صالح.',
  AppStrings.errorInvalidPhone: 'أدخل رقم هاتف صالح.',
  AppStrings.errorPasswordTooShort: 'استخدم 6 أحرف على الأقل.',
  AppStrings.errorPasswordNoUppercase: 'أضف حرفًا كبيرًا واحدًا على الأقل.',
  AppStrings.errorPasswordNoLowercase: 'أضف حرفًا صغيرًا واحدًا على الأقل.',
  AppStrings.errorPasswordNoDigit: 'قم بتضمين رقم واحد على الأقل.',
  AppStrings.errorPasswordNoSpecialChar: 'أضف رمزًا خاصًا واحدًا (مثال: !@#).',
  AppStrings.errorPasswordsDoNotMatch: 'كلمتا المرور غير متطابقتين.',
  AppStrings.errorInvalidUsername: 'يجب أن يكون اسم المستخدم من 3 إلى 16 حرفًا، يبدأ بحرف ويستخدم فقط الحروف أو الأرقام أو الشرطة السفلية.',
  AppStrings.errorInvalidFullName: 'أدخل اسمًا صحيحًا',
  AppStrings.errorInvalidUrl: 'أدخل رابطًا (URL) صالحًا.',
};