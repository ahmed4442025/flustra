// lib/data/fake_products_data.dart
import 'dart:math';
import '../models/product.dart';

class FakeProductsData {
  static final Random _random = Random();

  // A list of fun and energetic promotional banner messages.
  static const List<String> promoMessages = [
    "🔥 FLASH SALE! 50% OFF EVERYTHING! Grab it now! 🚀",
    "🎉 Weekend Bonanza! Unbelievable deals just for you! 🛍️",
    "✨ New Arrivals are HERE! Be the first to own them! ✨",
    "💸 Clear-out Sale! Prices so low, they're practically a steal! 💸",
    "🌟 Exclusive Offer! Get a free gift with every purchase over \$50! 🎁",
    "⏰ Limited Time Only! Don't walk, RUN! These deals won't last! 🏃‍♀️",
    "😎 Style Upgrade! Refresh your wardrobe with our latest collection! 😎",
    "💥 MEGA DEALS! Up to 70% off on select items! Shop now! 💥",
  ];

  // A list of category names with emojis.
  static const List<String> categories = [
    "📱 Electronics",
    "👗 Fashion",
    "🏠 Home & Kitchen",
    "📚 Books",
    "💪 Health & Fitness",
    "🧸 Toys & Games",
    "💄 Beauty",
    "👟 Shoes",
    "🌿 Groceries",
    "🚗 Automotive"
  ];

  // A list of 20 dynamically generated fake products.
  static final List<Product> products = List.generate(
    20,
        (index) {
      final originalPrice = (20 + _random.nextDouble() * 200).roundToDouble();
      final discount = (0.2 + _random.nextDouble() * 0.4); // 20% to 60% off
      final discountedPrice = (originalPrice * (1 - discount)).roundToDouble();

      return Product(
        name: 'Product #${index + 1}',
        originalPrice: originalPrice,
        discountedPrice: discountedPrice,
        description:
        'This is a short, compelling description for product #${index + 1}. It is designed to be modern and fresh.',
      );
    },
  );
}