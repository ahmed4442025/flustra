import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flustra_template/core/common/error_handler/failure.dart';

import '../../models/product.dart';
import '../products_fake_data.dart';

abstract class ProductsRepo {
  Future<Either<Failure, String>> getBanner();

  Future<Either<Failure, List<String>>> getCategories();

  Future<Either<Failure, List<Product>>> getProducts();
}

class ProductsImp implements ProductsRepo {
  @override
  Future<Either<Failure, String>> getBanner() async {
    await Future.delayed(const Duration(seconds: 1));
    return right(FakeProductsData.promoMessages[Random().nextInt(FakeProductsData.promoMessages.length)]);
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    return right(FakeProductsData.categories);
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    return right(FakeProductsData.products);
  }
}
