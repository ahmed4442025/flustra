import 'package:flustra_template/core/extensions/trans_extention.dart';
import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flustra_template/core/localization/app_strings_localizations.dart';
import 'package:flustra_template/core/services/console_printer.dart';

import 'network_toast_banner.dart';

enum InternetCubitTypes { network }

class InternetCubit extends BaseCubit<InternetCubitTypes> {
  InternetCubit() : super(InternetCubitTypes.network);

  static InternetCubit get i => getIt<InternetCubit>();

  // ========================== 🔥 checker 🔥 ==========================
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  @override
  void init() async {
    _handelConnection(await _isNetworkActive());
    _initNetworkListener();
    super.init();
  }

  void _initNetworkListener() {
    Connectivity().onConnectivityChanged.listen((result) {
      bool connected = !result.contains(ConnectivityResult.none);
      _handelConnection(connected);
    });
  }

  Future<bool> _isNetworkActive() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  void _handelConnection(bool connect) {
    if (connect == _isConnected) return;
    _isConnected = connect;

    if (connect) {
      NetworkToastBanner.showConnectedBanner();
      printColored(AppStrings.connected.tx(), textColor: ConsoleColor.green);
    } else {
      NetworkToastBanner.showNoInternetBanner();
      printColored(AppStrings.noInternet.tx(), textColor: ConsoleColor.red);
    }

    fire(InternetCubitTypes.network);
  }
}
