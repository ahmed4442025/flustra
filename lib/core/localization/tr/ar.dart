import 'app_strings_localizations.dart';

const Map<String, dynamic> arJson = {
  ...arJsonValidators,
  ...enJsonErrorHandler,
};

const Map<String, dynamic> enJsonErrorHandler = {
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

const Map<String, String> arJsonValidators = {
  AppStrings.errorEmptyField: "هذا الحقل مطلوب.",
  AppStrings.errorInvalidEmail: "يرجى إدخال بريد إلكتروني صالح.",
  AppStrings.errorInvalidPhone: "يرجى إدخال رقم هاتف صالح.",
  AppStrings.errorPasswordTooShort: "يجب أن تكون كلمة المرور 6 أحرف على الأقل.",
  AppStrings.errorPasswordNoUppercase: "يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل.",
  AppStrings.errorPasswordNoLowercase: "يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل.",
  AppStrings.errorPasswordNoDigit: "يجب أن تحتوي كلمة المرور على رقم واحد على الأقل.",
  AppStrings.errorPasswordNoSpecialChar: "يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل.",
  AppStrings.errorPasswordsDoNotMatch: "كلمتا المرور غير متطابقتين.",
  AppStrings.errorInvalidUsername: "يجب أن يكون اسم المستخدم من 3 إلى 16 حرفًا ويتكون من أحرف وأرقام.",
  AppStrings.errorInvalidFullName: "يرجى إدخال اسم كامل صالح.",
  AppStrings.errorInvalidUrl: "يرجى إدخال رابط إلكتروني صالح."
};
