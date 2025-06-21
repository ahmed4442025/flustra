// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:share_plus/share_plus.dart';

class MyFirebaseTokenWidget extends StatefulWidget {
  const MyFirebaseTokenWidget({super.key});

  @override
  State<MyFirebaseTokenWidget> createState() => _MyFirebaseTokenWidgetState();
}

class _MyFirebaseTokenWidgetState extends State<MyFirebaseTokenWidget> {
  String token = "TEMP_TOKEN";

  @override
  void initState() {
    // FirebaseMessaging.instance.getToken().then((value) {
    //   token = value ?? '';
    //   if (mounted) setState(() {});
    // });
    // TODO: implement initState
    super.initState();
  }

  bool isCopyLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Text(token)),
        const SizedBox(width: 10),
        if (token.isNotEmpty)
          Column(
            children: [
              GestureDetector(onTap: onTapShare, child: const Icon(Icons.share)),
              GestureDetector(onTap: onTapCopy, child: Icon(isCopyLoading ? Icons.check_rounded : Icons.copy)),
            ],
          ),
      ],
    );
  }

  void onTapShare() async {
    // Share.share(token);
  }
  void onTapCopy() async {
    if (isCopyLoading) return;
    isCopyLoading = true;
    setState(() {});
    await Clipboard.setData(ClipboardData(text: token));
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() {});
    isCopyLoading = false;
  }
}
