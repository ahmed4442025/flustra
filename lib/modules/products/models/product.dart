// lib/models/product.dart
class Product {
  final String name;
  final double originalPrice;
  final double discountedPrice;
  final String description;

  const Product({
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.description,
  });
}