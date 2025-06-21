import 'package:flutter/material.dart';

import '../../constants/app_defults.dart';
import '../../theme/base_theme_data.dart';

class ValidationWidget<T> extends StatefulWidget {
  final ValidationController controller;
  final AutovalidateMode? autoValidateMode;
  final double width;
  final Widget child;

  const ValidationWidget({
    super.key,
    required this.controller,
    required this.child,
    this.width = double.infinity,
    this.autoValidateMode,
  });

  @override
  State<ValidationWidget<T>> createState() => _ValidationWidgetState<T>();
}

class _ValidationWidgetState<T> extends State<ValidationWidget<T>> {
  late final ValidationController _controller = widget.controller;

  @override
  void initState() {
    _controller.addListener(didChange);
    super.initState();
  }

  void didChange() => fieldState.didChange("");

  @override
  void dispose() {
    _controller.removeListener(didChange);
    _controller.dispose();
    super.dispose();
  }

  late FormFieldState fieldState;

  @override
  Widget build(BuildContext context) {
    return FormField(
      autovalidateMode: widget.autoValidateMode,
      builder: (field) {
        fieldState = field;

        final showError = !_controller.validate(force: false);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: widget.width,
              decoration: BoxDecoration(
                borderRadius: borderTextFieldRadius,
                border: showError ? Border.all(color: AppColors.error, width: 1) : null,
              ),
              child: Padding(
                padding: showError ? const EdgeInsets.all(2.0) : EdgeInsets.zero,
                child: widget.child,
              ),
            ),
            if (showError) ...[
              SizedBox(height: 4),
              Text(
                _controller.validator?.call() ?? "",
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.error),
              ),
            ],
          ],
        );
      },
    );
  }
}

// ========================== 🔥 Generic Validation Controller 🔥 ==========================
class ValidationController extends ChangeNotifier {
  final String? Function()? validator;

  ValidationController({this.validator});

  // // -------------------------- Validate method --------------------------
  bool validate({bool force = true}) {
    if (force) notifyListeners();
    return validator?.call() == null;
  }
}
