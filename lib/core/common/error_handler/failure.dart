import '../../services/app_snake_bar.dart';

class Failure {
  int code; // 200, 201, 400, 303..500 and so on
  String message; // error , success
  TypeMsg type;

  Failure(this.code, this.message, this.type);

  @override
  String toString() {
    return 'Failure{code: $code, message: $message, type: $type}';
  }

  void printInfo(String from) {
    print('from => $from : Failure{code: $code, message: $message, type: $type}');
  }
}

enum TypeMsg { ok, error, warning }

extension FailureEx on Failure {
  void showToast() {
    ToastType toastType = switch (type) {
      TypeMsg.ok => ToastType.info,
      TypeMsg.error => ToastType.error,
      TypeMsg.warning => ToastType.warning,
    };

    AppSnackBar.show(message, type: toastType);
  }
}
