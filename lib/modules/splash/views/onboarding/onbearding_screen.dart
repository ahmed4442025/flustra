import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/constants/app_images.dart';
import 'package:flustra_template/core/data/cache/cache_key.dart';
import 'package:flustra_template/core/router/app_router.dart';
import 'package:flustra_template/core/router/route_help_methods.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static const String name = AppRoutes.onboarding;

  static void navigateToMe({NavigationType type = NavigationType.finish}) => navigateTo(name, type: type);

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // للتحكم في PageView
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // قائمة محتوى الصفحات
  final List<Map<String, String>> _onboardingData = [
    {
      "title": "مرحباً بك في تطبيقنا!",
      "description": "اكتشف ميزات رائعة تجعل حياتك أسهل.",
      "image": AppAssetsImages.onboarding.onboarding1,
    },
    {
      "title": "سهولة الاستخدام",
      "description": "واجهة بسيطة وتصميم جذاب لتجربة مستخدم ممتعة.",
      "image": AppAssetsImages.onboarding.onboarding2,
    },
    {
      "title": "ابدأ الآن!",
      "description": "انضم إلينا واستمتع بكل ما نقدمه لك.",
      "image": AppAssetsImages.onboarding.onboarding3,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    AppCache.saveData(key: CacheKey.skipOnBoarding, value: true);
    navigateTo(AppRoutes.login, type: NavigationType.finish);
    // navigateTo(AppRoutes.themeShowcaseScreen, type: NavigationType.finish);
  }

  void _onNext() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // هذه هي الصفحة الأخيرة، انتقل إلى الشاشة الرئيسية
      _onSkip();
    }
  }

  void _onBack() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (v, _) {
        if (v) return;
        _onBack();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: _onSkip,
              child: const Text("تخطي"),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPageContent(
                    title: _onboardingData[index]['title']!,
                    description: _onboardingData[index]['description']!,
                    imagePath: _onboardingData[index]['image']!,
                  );
                },
              ),
            ),
            // مؤشر الصفحات (النقاط)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => buildDot(index, context),
              ),
            ),
            const SizedBox(height: 30),
            // الأزرار السفلية
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر الرجوع (يظهر فقط إذا لم تكن الصفحة الأولى)
                  if (_currentPage > 0)
                    OutlinedButton(
                      onPressed: _onBack,
                      child: const Text("السابق"),
                    )
                  else
                    // عنصر نائب للحفاظ على التباعد عندما يكون زر الرجوع مخفياً
                    const SizedBox(width: 100), // يمكنك تعديل العرض حسب الحاجة

                  // زر التالي أو إنهاء
                  ElevatedButton(
                    onPressed: _onNext,
                    child: Text(
                      _currentPage == _onboardingData.length - 1 ? "إنهاء" : "التالي",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت لبناء النقطة لمؤشر الصفحة
  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppColors.primary : Colors.grey[400],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

// ويدجت لعرض محتوى كل صفحة onboarding
class OnboardingPageContent extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath; // مسار الصورة

  const OnboardingPageContent({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // استخدام Image.asset لعرض الصورة
          // تأكد من وجود الصور في المسار المحدد
          Image.asset(
            imagePath,
            height: 250, // يمكنك تعديل الارتفاع
            errorBuilder: (context, error, stackTrace) {
              // في حال لم يتم العثور على الصورة، اعرض نصاً بديلاً
              return Container(
                height: 250,
                color: Colors.grey[200],
                child: Center(
                  child: Text(
                    "Image not found",
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.displayLarge.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
