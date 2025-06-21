import 'package:flutter/material.dart';

class ClearTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const ClearTextFieldWidget({super.key, required this.controller});

  @override
  State<ClearTextFieldWidget> createState() => _ClearTextFieldWidgetState();
}

class _ClearTextFieldWidgetState extends State<ClearTextFieldWidget> {
  late bool show = widget.controller.text.isNotEmpty;

  @override
  void initState() {
    widget.controller.addListener(() {
      bool oldState = show;
      show = widget.controller.text.isNotEmpty;
      if (oldState != show && mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();
    return InkWell(
      onTap: () => widget.controller.clear(),
      child: const Icon(Icons.close, size:15, color: Colors.black54),
    );
  }
}
