import 'package:bella_banga/src/model/bottom_navy_bar_item.dart';
import 'package:bella_banga/src/model/recommended_product.dart';
import 'package:flutter/material.dart';

class AppData {
  const AppData._();

  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  static List<BottomNavyBarItem> bottomNavyBarItems = [
    BottomNavyBarItem(
      "Home",
      const Icon(Icons.home),
      const Color(0xffFA9833),
      Colors.grey,
    ),
    BottomNavyBarItem(
      "Category",
      const Icon(Icons.category),
      const Color(0xffFA9833),
      Colors.grey,
    ),
    BottomNavyBarItem(
      "Cart",
      const Icon(Icons.shopping_cart),
      const Color(0xffFA9833),
      Colors.grey,
    ),
    BottomNavyBarItem(
      "Profile",
      const Icon(Icons.person),
      const Color(0xffFA9833),
      Colors.grey,
    ),
  ];

  static List<RecommendedProduct> recommendedProducts = [
    RecommendedProduct(
      imagePath: "",
      cardBackgroundColor: const Color(0x00af750c),
    ),
    RecommendedProduct(
      imagePath: "",
      cardBackgroundColor: const Color(0xFF3081E1),
      buttonBackgroundColor: const Color(0xFF9C46FF),
      buttonTextColor: Colors.white,
    ),
  ];
}
