import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pripo/core/data/network/IApiService.dart';
import 'package:pripo/core/router/app_router.dart';
import 'package:pripo/core/router/route_help_methods.dart';
import 'package:pripo/core/services/app_snake_bar.dart';
import 'package:pripo/modules/auth/logic/auth_cubit.dart';

import '../../services/proxy_cach.dart';

/// ProxyScreenController can be used to manage state and notify listeners about changes.
class ProxyScreenController extends ChangeNotifier {
  // ========================== Constructor ==========================
  ProxyScreenController();

  // ========================== 🔒 Private variables 🔒 ==========================
  /// Private variables These variables should be private to the controller and accessed through public methods.

  final ProxyManager _proxyManager = ProxyManager();

  // ========================== 🗝️ Public variables 🗝️ ==========================
  /// These variables are accessible to the widgets or other parts of the app.

  final TextEditingController proxyController = TextEditingController();

  List<String> get proxies => _proxyManager.proxies;
  List<String> myIp = [""];

  // ========================== 🔥 initialization 🔥 ==========================
  ///  Initialization logic and variables or call initialization methods.
  void init() {
    _getStoredProxy();
    _setIp();
  }

// ========================== 🌍 Public methods and events 🌍 ==========================
  /// These methods are used by the UI or other logic to interact with the controller. => Call notifyListeners() to update the UI

  // -------------------------- test proxy --------------------------
  void onTapTheme(){
    navigateTo(AppRoutes.themeShowcaseScreen);
    // AuthCubit.i.login(username: "Abdo3", password: "123456");
  }
  // -------------------------- onTapProxyChip --------------------------

  void onTapProxyChip(String proxy) => proxyController.text = proxy;

  // --------------------------  --------------------------
  void removeProxyFromList(String proxy) async {
    await _proxyManager.removeProxy(proxy);
    notifyListeners();
  }

  // --------------------------  --------------------------
  Future onTapStop() async {
    DioHelper.setProxy(null);
    notifyListeners();
  }

  // --------------------------  --------------------------
  Future onTapAdd() async {
    _addProxyToList(proxyController.text);
    print("added proxy ${_proxyManager.proxies}");
  }

  // --------------------------  --------------------------


  Future onTapSave() async {
    String proxyString = proxyController.text;
    if (proxyString.isEmpty) {
      DioHelper.setProxy(null);
      notifyListeners();
      AppSnackBar.show("success remove proxy", type: ToastType.success);
      return;
    }
    if (!_isValidProxy(proxyString)) {
      AppSnackBar.show("Not valid proxy", type: ToastType.error);
    }
    if (_isValidProxy(proxyString)) {
      String? setProxy = DioHelper.setProxy(proxyString);
      notifyListeners();
      if (setProxy == null) AppSnackBar.show("success set proxy", type: ToastType.success);
      if (setProxy != null) AppSnackBar.show(setProxy, type: ToastType.success);
    }
  }

// ========================== 🔒 Private methods 🔒 ==========================
  /// These are internal methods specific to the controller, Use them to encapsulate any logic that doesn't need to be exposed.

  // --------------------------  --------------------------
  void _addProxyToList(String proxy) async {
    await _proxyManager.addProxy(proxy);
    notifyListeners();
  }

  // --------------------------  --------------------------
  Future<void> _setIp() async {
    var interface = await NetworkInterface.list();
    myIp = [];
    for (var element in interface) {
      print(element);
      for (var element2 in element.addresses) {
        myIp.add(element2.address);
      }
    }
    // _myIp = interface.map((e) => [e.addresses.map((e) => e.address).toList()]).toList() ?? [];
    String? ip = myIp.firstOrNull;
    print("_myIp ${myIp.length}");
    print("_myIp ${myIp}");
    if (ip != null) proxyController.text = "$ip:8888";
    notifyListeners();
  }

  // --------------------------  --------------------------
  void _getStoredProxy() async {
    _proxyManager.getStringArray();
    notifyListeners();
  }

  // --------------------------  --------------------------
  bool _isValidProxy(String proxy) {
    RegExp regExp = RegExp(
      r'^((([0-9]{1,3}\.){3}[0-9]{1,3})|(([a-fA-F0-9]{1,4}:){7}[a-fA-F0-9]{1,4}))(:[0-9]{1,5})?$',
      caseSensitive: false,
      multiLine: false,
    );
    return regExp.hasMatch(proxy);
  }
}
