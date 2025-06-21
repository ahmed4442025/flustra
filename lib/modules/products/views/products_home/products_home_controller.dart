import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/core/services/app_snake_bar.dart';
import 'package:flustra_template/core/services/bot_toast/app_bot_toast.dart';
import 'package:flustra_template/modules/products/models/product.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';

/// ProductsHomeController can be used to manage state and notify listeners about changes.
class ProductsHomeController extends ChangeNotifier {
  // ========================== Constructor ==========================
  ProductsHomeController();

  // ========================== 🔒 Private variables 🔒 ==========================
  /// Private variables These variables should be private to the controller and accessed through public methods.

  final ProductsCubit _cubit = ProductsCubit.get();

  List<String>? _categories;

  List<Product>? _products;

  // ========================== 🗝️ Public variables 🗝️ ==========================
  /// These variables are accessible to the widgets or other parts of the app.

  String get banner => _cubit.banner ?? "";

  List<String> get categories => _categories ?? [];

  List<Product> get products => _products ?? [];

  // ========================== 🔥 initialization 🔥 ==========================
  ///  Initialization logic and variables or call initialization methods.
  void init() async {
    getBanner();

    getCategories();

    getProducts();
  }

// ========================== 🌍 Public methods and events 🌍 ==========================
  /// These methods are used by the UI or other logic to interact with the controller. => Call notifyListeners() to update the UI

  // -------------------------- get banner --------------------------
  void getBanner() {
    if(_cubit.stateOf(ProductsCubitTypes.banner).isLoading())  return AppBotToast.show("please wait don't spam", type: ToastType.warning);
    _cubit.getBanner();
  }

  // -------------------------- get categories --------------------------
  void getCategories() {
    if(_cubit.stateOf(ProductsCubitTypes.categories).isLoading())  return AppSnackBar.show("please wait don't spam", type: ToastType.warning);;
    _cubit.getCategories(onSuccess: (r) => _categories = r);
  }

  // -------------------------- get products  --------------------------
  void getProducts() async {
    if(_cubit.stateOf(ProductsCubitTypes.products).isLoading()) return AppSnackBar.show("please wait don't spam", type: ToastType.warning);
    var res = await _cubit.getProducts();
    res.fold(
      (l) => null,
      (r) => _products = r,
    );
  }
// ========================== 🔒 Private methods 🔒 ==========================
  /// These are internal methods specific to the controller, Use them to encapsulate any logic that doesn't need to be exposed.
}
