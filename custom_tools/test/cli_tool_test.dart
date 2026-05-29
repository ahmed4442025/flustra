import 'package:test/test.dart';
import '../run.dart' as run_cli;

void main() {
  group('Developer Tools CLI Integration Tests', () {
    test('Verify translation addition with identical and duplicate values', () {
      print('--- TEST: Running add_trans with identical, duplicate, and new keys ---');
      run_cli.main([
        'add_trans',
        'key|en|ar;testClikey|Test CLI Tool|اختبار أداة الـ CLI;anotherDuplicateKey|Test CLI Tool|اختبار أداة الـ CLI;genNewKey|Gen Unique Value|قيمة توليد فريدة'
      ]);
    });
  });
}
