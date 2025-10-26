import 'package:flutter/material.dart';

import '../../constants/app_defults.dart';
import '../../theme/base_theme_data.dart';

/// ✅ Widget مخصصة للـ Validation باستخدام Controller خارجي
class ValidationWidget<T> extends StatefulWidget {
  final ValidationController controller;
  final AutovalidateMode? autoValidateMode;
  final double width;
  final Widget child;

  const ValidationWidget({super.key, required this.controller, required this.child, this.width = double.infinity, this.autoValidateMode});

  @override
  State<ValidationWidget<T>> createState() => _ValidationWidgetState<T>();
}

class _ValidationWidgetState<T> extends State<ValidationWidget<T>> {
  late final ValidationController _controller = widget.controller;

  FormFieldState<String>? _fieldState; // ✅ خليها nullable لتجنب مشاكل التوقيت

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    // ✅ استخدم validate بدل didChange("")
    if (mounted && _fieldState != null && _fieldState!.mounted) {
      _fieldState!.validate();
    }
  }

  @override
  void dispose() {
    // ❌ ما نعملش dispose للـ controller هنا
    // لأن ممكن يكون مستخدمه برة أو في أكثر من ويدجت
    _controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      autovalidateMode: widget.autoValidateMode,
      validator: (_) => _controller.validator?.call(), // ✅ خلي الـ FormField نفسه يستخدم الفاليديتور
      builder: (field) {
        _fieldState = field;

        final hasError = field.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: borderTextFieldRadius,
                border: hasError ? Border.all(color: AppColors.error, width: 1) : null,
              ),
              child: Padding(padding: hasError ? const EdgeInsets.all(2.0) : EdgeInsets.zero, child: widget.child),
            ),
            if (hasError) ...[const SizedBox(height: 4), Text(field.errorText ?? "", style: AppTextStyle.bodySmall.copyWith(color: AppColors.error))],
          ],
        );
      },
    );
  }
}

/// ========================== 🔥 Controller محسّن 🔥 ==========================
class ValidationController extends ChangeNotifier {
  final String? Function()? validator;

  ValidationController({this.validator});

  /// ✅ دالة التحقق العامة
  bool validate({bool force = true}) {
    if (force) notifyListeners();
    return validator?.call() == null;
  }
}
