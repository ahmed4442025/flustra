import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flutter/material.dart';

import '../../logic/products_cubit.dart';
import '../../widgets/banner_widget.dart';
import '../../widgets/category_list_widget.dart';
import '../../widgets/product_card.dart';
import 'products_home_controller.dart';

class ProductsHomeScreen extends StatefulWidget {
  const ProductsHomeScreen({super.key});

  @override
  State<ProductsHomeScreen> createState() => _ProductsHomeScreenState();
}

class _ProductsHomeScreenState extends State<ProductsHomeScreen> {
  void _refresh() {
    if (mounted) setState(() {});
  }

  late final ProductsHomeController _controller = ProductsHomeController();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buttons(),
              SizedBox(height: 30),
              Center(child: buildBannerListener()),
              SizedBox(height: 30),
              buildListCategoriesListener(),
              SizedBox(height: 30),
              Text('Featured Products', style: AppTextStyle.titleLarge),
              SizedBox(height: 10),
              buildListProductsListener(),
              SizedBox(height: 20), // Add some padding at the bottom
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------- buttons --------------------------
  Widget buttons() {
    return Row(
      children: [
        TextButton(onPressed: _controller.getBanner, child: Text("Get banner")),
        SizedBox(width: 10),
        TextButton(onPressed: _controller.getCategories, child: Text("Get categories")),
        SizedBox(width: 10),
        TextButton(onPressed: _controller.getProducts, child: Text("Get products")),
      ],
    );
  }

  // -------------------------- Banner --------------------------
  Widget buildBannerListener() {
    return BlockBuilderWidget<ProductsCubit, ProductsCubitTypes>(
      types: const [ProductsCubitTypes.banner],
      body: (_) => BannerWidget(message: _controller.banner),
      loading: (_) => ShimmerTemplates.banner(),
      error: (_) => ShimmerTemplates.banner(),
    );
  }

  // -------------------------- categories --------------------------
  Widget buildListCategoriesListener() {
    return BlockBuilderWidget<ProductsCubit, ProductsCubitTypes>(
      types: const [ProductsCubitTypes.categories],
      body: (_) => CategoryListWidget(loading: false, categories: _controller.categories),
      loading: (_) => CategoryListWidget(loading: true),
      error: (_) => CategoryListWidget(loading: false),
    );
  }

  // -------------------------- products --------------------------
  Widget buildListProductsListener() {
    return BlockBuilderWidget<ProductsCubit, ProductsCubitTypes>(
      types: const [ProductsCubitTypes.products],
      body: (_) => buildListProducts(loading: false),
      loading: (_) => buildListProducts(loading: true),
      error: (_) => buildListProducts(loading: false),
    );
  }

  Widget buildListProducts({required bool loading}) {
    final products = _controller.products;
    double width = context.width;
    final crossAxisCount = (width ~/ 250).clamp(2, 6);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2 / 2,
      ),
      itemCount: loading ? 10 : products.length,
      itemBuilder: (context, index) {
        if (loading) return ShimmerTemplates.productCard();
        return ProductCard(product: products[index]);
      },
    );
  }
}
