import 'package:flustra_template/core/constants/app_defults.dart';
import 'package:flustra_template/core/extensions/context_get_x.dart';
import 'package:flustra_template/core/helper/base_cubit/block_builder_widget.dart';
import 'package:flustra_template/core/helper/uti/shimmer_templates.dart';
import 'package:flustra_template/core/helper/utils/dimensions.dart';
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
  late final ProductsHomeController _controller = ProductsHomeController();

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_refresh);
    _controller.init();
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingScreen),
          child: _buildBody(),
        ),
      ),
    );
  }

  // --------------------------[ Body ]-------------------------- //
  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------[ Debug Controls ]-------------------------- //
        const SizedBox(height: Dimensions.paddingScreen),
        _buildDebugControls(),  const SizedBox(height: Dimensions.paddingScreen),
        // --------------------------[ Header ]-------------------------- //
        _buildHeader(),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        // --------------------------[ Banner ]-------------------------- //
        _buildBanner(),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        // --------------------------[ Categories ]-------------------------- //
        _buildCategories(),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        // --------------------------[ Products Header ]-------------------------- //
        _buildProductsHeader(),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        // --------------------------[ Products Grid ]-------------------------- //
        _buildProductsGrid(),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),

      ],
    );
  }

  // --------------------------[ Header ]-------------------------- //
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover',
              style: AppTextStyle.displaySmall.copyWith(fontWeight: FontWeight.w900, color: AppColors.onSurface),
            ),
            const SizedBox(height: 4),
            Text('Find the best products for you', style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),
        GestureDetector(
          onTap: () => _controller.init(),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.outlineVariant, width: 1),
            ),
            child: Icon(Icons.refresh_rounded, color: AppColors.primary, size: 22),
          ),
        ),
      ],
    );
  }

  // --------------------------[ Banner ]-------------------------- //
  Widget _buildBanner() {
    return BlockBuilderWidget<ProductsCubit, ProductsCubitTypes>(
      types: const [ProductsCubitTypes.banner],
      body: (_) => BannerWidget(message: _controller.banner),
      loading: (_) => ShimmerTemplates.banner(),
      error: (_) => ShimmerTemplates.banner(),
    );
  }

  // --------------------------[ Categories ]-------------------------- //
  Widget _buildCategories() {
    return BlockBuilderWidget<ProductsCubit, ProductsCubitTypes>(
      types: const [ProductsCubitTypes.categories],
      body: (_) => CategoryListWidget(
        loading: false,
        categories: _controller.categories,
        selectedCategory: _controller.selectedCategory,
        onCategorySelected: _controller.selectCategory,
      ),
      loading: (_) => const CategoryListWidget(loading: true),
      error: (_) => const CategoryListWidget(loading: false),
    );
  }

  // --------------------------[ Products Header ]-------------------------- //
  Widget _buildProductsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _controller.selectedCategory == null ? 'Featured Products' : '${_controller.selectedCategory} Products',
          style: AppTextStyle.titleLarge.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.bold),
        ),
        if (_controller.selectedCategory != null) TextButton(onPressed: () => _controller.selectCategory(null), child: const Text('Clear Filter')),
      ],
    );
  }

  // --------------------------[ Products Grid ]-------------------------- //
  Widget _buildProductsGrid() {
    return BlockBuilderWidget<ProductsCubit, ProductsCubitTypes>(
      types: const [ProductsCubitTypes.products],
      body: (_) => _buildListProducts(isLoading: false),
      loading: (_) => _buildListProducts(isLoading: true),
      error: (_) => _buildListProducts(isLoading: false),
    );
  }

  Widget _buildListProducts({required bool isLoading}) {
    final products = _controller.products;

    if (!isLoading && products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: [
              Icon(Icons.inbox_rounded, size: 48, color: AppColors.hint),
              const SizedBox(height: 16),
              Text('No products found in this category.', style: AppTextStyle.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
      );
    }

    final double width = context.width;
    final int crossAxisCount = (width ~/ 180).clamp(2, 6);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: Dimensions.paddingSizeDefault,
        mainAxisSpacing: Dimensions.paddingSizeDefault,
        childAspectRatio: 0.68,
      ),
      itemCount: isLoading ? 6 : products.length,
      itemBuilder: (context, index) {
        if (isLoading) return ShimmerTemplates.productCard();
        return ProductCard(product: products[index]);
      },
    );
  }

  // --------------------------[ Debug Controls ]-------------------------- //
  Widget _buildDebugControls() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(onPressed: _controller.getBanner, icon: const Icon(Icons.refresh_rounded, size: 16), label: const Text("Banner")),
          const SizedBox(width: 8),
          TextButton.icon(onPressed: _controller.getCategories, icon: const Icon(Icons.category_rounded, size: 16), label: const Text("Categories")),
          const SizedBox(width: 8),
          TextButton.icon(onPressed: _controller.getProducts, icon: const Icon(Icons.grid_view_rounded, size: 16), label: const Text("Products")),
        ],
      ),
    );
  }
}
