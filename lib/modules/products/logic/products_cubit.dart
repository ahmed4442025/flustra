import 'package:flustra_template/core/get_it/get_it.dart';
import 'package:flustra_template/core/helper/base_cubit/bse_cubit.dart';
import 'package:flustra_template/modules/products/models/product.dart';

import '../data/products/repo.dart';

enum ProductsCubitTypes {
  none,
  banner,
  categories,
  products,
}

class ProductsCubit extends BaseCubit<ProductsCubitTypes> {
  ProductsCubit() : super(ProductsCubitTypes.none);

  static ProductsCubit get() => getIt<ProductsCubit>();

  final ProductsRepo _repo = ProductsImp();

// ========================== 🔥 banner 🔥 ==========================
  String? banner;

  BaseEitherResponse<String> getBanner() {
    return fastFire<String>(
      type: ProductsCubitTypes.banner,
      fun: _repo.getBanner,
      onSuccess: (r) => banner = r,
    );
  }

// ========================== 🔥 categories 🔥 ==========================
  BaseEitherResponse<List<String>> getCategories({Function(List<String> x)? onSuccess}) {
    return fastFire<List<String>>(
      type: ProductsCubitTypes.categories,
      fun: _repo.getCategories,
      onSuccess: (r) => onSuccess?.call(r),
    );
  }

// ========================== 🔥 products 🔥 ==========================
  BaseEitherResponse<List<Product>> getProducts() {
    return fastFire<List<Product>>(
      type: ProductsCubitTypes.products,
      fun: _repo.getProducts,
      onSuccess: x,
    );
  }
}
