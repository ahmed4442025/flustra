class Product {
  final String name;
  final double originalPrice;
  final double discountedPrice;
  final String description;
  final String category;
  final String imageUrl;

  const Product({
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.description,
    required this.category,
    required this.imageUrl,
  });
}
