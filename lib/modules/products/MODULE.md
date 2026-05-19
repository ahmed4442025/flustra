# Products Module

## 1. Overview
The Products module is responsible for displaying the items catalog to the user. It features categorizations, product listings with detail cards, and a dynamic promotional banner to highlight active deals and flash sales.

## 2. Core Features
- **Discover Catalog**: Displays a modern feed of products with high-resolution imagery, descriptive copy, original/discounted pricing, and quick-add to cart controls.
- **Promotional Banner**: Highlights flash sales or exclusive deals at the top of the feed with styled linear gradients and tag overlays.
- **Category Filtering**: Allows users to filter the product list by categories (e.g., Electronics, Fashion, Groceries, etc.) via animated horizontal chips. Selecting a category dynamically updates the product grid.
- **Clear Filtering**: Offers a quick option to reset active filters and return to the main feed.

## 3. Business Logic & Rules
- **Product Details & Discount Calculations**: Each product has original and discounted prices. If a discount exists, it calculates and overlays a high-contrast percentage badge (e.g., `-30%`) on the product image.
- **Manual Data reloads**: Offers manual refresh actions (under the discover title and in the bottom debug controls) to fetch updated banner information, categories list, or product listings.
- **Asynchronous States**: Displays skeleton shimmers (matching card/list layouts) while the network requests are pending.

## 4. Recent Changes
- Redesigned the product feed with vibrant gradients, clean borders, and proper typography aligned with `AppColors` and `AppTextStyle`.
- Updated the fake data generator to provide categorizations and high-quality Unsplash image URLs instead of simple placeholders.
- Created `CategoryListWidget` supporting select, toggle, and dynamic filtering within the home controller.
- Integrated `CachedImageWidget` for fast, cached network image rendering.
