import 'console_printer.dart';

class FakeImageService {
  static String getRandomImageUrl({required String keyword, int width = 1080, int height = 720}) {
    final formattedKeyword = Uri.encodeComponent(keyword);

    final int seed = DateTime.now().millisecondsSinceEpoch;
    String imgUrl = 'https://loremflickr.com/$width/$height/$formattedKeyword?lock=$seed';
    // 'https://image.pollinations.ai/prompt/$formattedKeyword?width=$width&height=$height&seed=$seed&nologo=true';
    "new image generated $imgUrl".printWithColor(textColor: ConsoleColor.green);
    return imgUrl;
  }
}
