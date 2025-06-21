import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flustra_template/modules/products/data/products_fake_data.dart';
import 'package:flutter/material.dart';

import '../widgets/banner_widget.dart';
import '../widgets/category_list_widget.dart';
import '../widgets/product_card.dart';

class ProductsHomeScreen extends StatefulWidget {
  const ProductsHomeScreen({super.key});

  @override
  State<ProductsHomeScreen> createState() => _ProductsHomeScreenState();
}

class _ProductsHomeScreenState extends State<ProductsHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: BannerWidget()),
              SizedBox(height: 30),
              CategoryListWidget(),
              SizedBox(height: 30),
              Text('Featured Products', style: AppTextStyle.titleLarge),
              SizedBox(height: 10),
              buildListProducts(true),
              SizedBox(height: 20), // Add some padding at the bottom
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------- products --------------------------
  Widget buildListProductsListener() {
    return
  }
  Widget buildListProducts(bool loading) {
    final products = FakeProductsData.products;

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
