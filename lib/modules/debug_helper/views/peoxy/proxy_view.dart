import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pripo/core/data/network/IApiService.dart';
import 'package:pripo/core/extensions/color.dart';
import 'package:pripo/core/router/app_router.dart';
import 'package:pripo/core/router/route_help_methods.dart';

import '../../widgets/clear_text.dart';
import '../../widgets/my_firebase_token_widget.dart';
import 'proxy_screen_controller.dart';

class ProxyView extends StatefulWidget {
  static void navigateToMe() => navigateTo(AppRoutes.proxyView);

  const ProxyView({super.key});

  @override
  State<ProxyView> createState() => _ProxyViewState();
}

class _ProxyViewState extends State<ProxyView> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final ProxyScreenController _controller = ProxyScreenController();

  @override
  void initState() {
    _controller.addListener(_refresh);
    _controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          FloatingActionButton(
            onPressed: _controller.onTapTheme,
            child: Icon(Icons.color_lens_outlined),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("ProxyView"),
        actions: [
          CircleAvatar(backgroundColor: DioHelper.proxyRun != null ? Colors.greenAccent : Colors.redAccent, radius: 7),
          const SizedBox(width: 30),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyFirebaseTokenWidget(),
              const SizedBox(height: 10),
              if (true) ...[
                SizedBox(
                    height: 25,
                    child: DioHelper.proxyRun == null
                        ? null
                        : Text("current proxy : ${DioHelper.proxyRun}", style: const TextStyle(fontSize: 16, color: Color(0xff1e9506)))),
              ],
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _controller.myIp.length,
                itemBuilder: (_, i) => buildIp(_controller.myIp[i]),
                separatorBuilder: (_, __) => const SizedBox(height: 10),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controller.proxyController,
                decoration: InputDecoration(
                  suffixIcon: ClearTextFieldWidget(controller: _controller.proxyController),
                  prefixIcon: const Icon(Icons.network_check_outlined, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: _controller.onTapSave, style: getButtonTheme(Colors.green), child: Text("save"))),
                  if (DioHelper.proxyRun != null) ...[
                    const SizedBox(width: 15),
                    Expanded(child: ElevatedButton(onPressed: _controller.onTapStop, style: getButtonTheme(Colors.redAccent), child: Text("stop"))),
                  ],
                  const SizedBox(width: 15),
                  Expanded(child: ElevatedButton(onPressed: _controller.onTapAdd, style: getButtonTheme(Colors.deepPurple), child: Text("Add"))),
                ],
              ),
              const SizedBox(height: 10),
              buildChip(),
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle? getButtonTheme(Color clr) {
    return Theme.of(context).elevatedButtonTheme.style?.copyWith(backgroundColor: WidgetStateProperty.all(clr));
  }

  Row buildIp(String ip) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("My ip : $ip", style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        InkWell(onTap: () => Clipboard.setData(ClipboardData(text: ip)), child: const Icon(Icons.copy, color: Colors.brown)),
        const SizedBox(width: 10),
        InkWell(onTap: () => _controller.proxyController.text = ip, child: const Icon(Icons.arrow_downward_outlined, color: Colors.teal)),
      ],
    );
  }

  Widget buildChip() {
    return Container(
      height: MediaQuery.of(context).size.height * .4,
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(border: Border.all(color: Colors.purple.shade400, width: .2)),
      child: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Wrap(
          runSpacing: 8,
          spacing: 8,
          children: _controller.proxies.map((e) => proxyChip(e)).toList(),
        ),
      ),
    );
  }

  GestureDetector proxyChip(String e) {
    return GestureDetector(
      onTap: () => _controller.onTapProxyChip(e),
      child: Chip(
        label: Text(e),
        backgroundColor: Colors.red.withOpacityEX(.1),
        onDeleted: () => _controller.removeProxyFromList(e),
      ),
    );
  }
}
