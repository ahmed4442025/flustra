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
    "🚗 Automotive",
  ];

  static const List<String> categoryImages = [
    "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&q=80",
    "https://images.unsplash.com/photo-1558060370-d644479cb6f7?w=400&q=80",
    "https://images.unsplash.com/photo-1610348725531-843dff163e2c?w=400&q=80",
    "https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&q=80",
    "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=400&q=80",
    "https://images.unsplash.com/photo-1558060370-d644479cb6f7?w=400&q=80",
    "https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400&q=80",
    "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=400&q=80",
    "https://images.unsplash.com/photo-1610348725531-843dff163e2c?w=400&q=80",
    "https://images.unsplash.com/photo-1617788138017-80ad40651399?w=400&q=80",
  ];

  static const Map<String, List<String>> _categoryProducts = {
    "📱 Electronics": [
      "Wireless Headphones X1",
      "Smart Watch Pro",
      "Ultra Bluetooth Speaker",
    ],
    "👗 Fashion": [
      "Summer Dress Blue",
      "Casual Cotton T-Shirt",
      "Stylish Leather Jacket",
    ],
    "🏠 Home & Kitchen": [
      "Premium Coffee Maker",
      "Non-Stick Frying Pan",
      "Electric Kettle 1.5L",
    ],
    "📚 Books": [
      "The Art of Coding",
      "Mysterious Island Adventure",
      "Healthy Cooking Delights",
    ],
    "💪 Health & Fitness": [
      "Adjustable Dumbbells Set",
      "Yoga Mat Eco-Friendly",
      "Smart Fitness Tracker",
    ],
    "🧸 Toys & Games": [
      "Wooden Building Blocks",
      "Remote Control Car",
      "Plush Teddy Bear Classic",
    ],
    "💄 Beauty": [
      "Matte Lipstick Crimson",
      "Moisturizing Face Cream",
      "Organic Argan Hair Oil",
    ],
    "👟 Shoes": [
      "Running Sneakers Neon",
      "Classic Leather Loafers",
      "All-Weather Hiking Boots",
    ],
    "🌿 Groceries": [
      "Organic Honey 500g",
      "Green Tea Bags 50p",
      "Extra Virgin Olive Oil",
    ],
    "🚗 Automotive": [
      "Car Phone Mount Charger",
      "All-Weather Floor Mats",
      "Portable Air Compressor",
    ],
  };

  // A list of 30 dynamically generated fake products.
  static final List<Product> products = List.generate(30, (index) {
    final categoryIndex = index % categories.length;
    final category = categories[categoryIndex];
    final imageUrl = categoryImages[categoryIndex];

    final names = _categoryProducts[category] ?? ["Product #${index + 1}"];
    final name = names[index % names.length];

    final originalPrice = (20 + _random.nextDouble() * 200).roundToDouble();
    final discount = (0.15 + _random.nextDouble() * 0.35); // 15% to 50% off
    final discountedPrice = (originalPrice * (1 - discount)).roundToDouble();

    return Product(
      name: name,
      originalPrice: originalPrice,
      discountedPrice: discountedPrice,
      description:
          'This is a high-quality ${name.toLowerCase()} that offers exceptional performance and value. Perfect for daily use.',
      category: category,
      imageUrl: imageUrl,
    );
  });
}
