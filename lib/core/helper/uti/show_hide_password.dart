import 'package:flutter/material.dart';

class ShowHidePasswordWidget extends StatefulWidget {
  final Function(bool isPasswordShow) onChange;

  const ShowHidePasswordWidget({super.key, required this.onChange});

  @override
  State<ShowHidePasswordWidget> createState() => _ShowHidePasswordWidgetState();
}

class _ShowHidePasswordWidgetState extends State<ShowHidePasswordWidget> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          passwordVisible = !passwordVisible;
          widget.onChange(passwordVisible);
          setState(() {});
        },
        child: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey));
  }
}
