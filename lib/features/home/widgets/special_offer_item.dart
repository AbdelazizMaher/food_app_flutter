import 'package:flutter/material.dart';
import 'package:food_app_lab/models/meal_model.dart';

import '../../../models/category_filter_model.dart';

class SpecialOfferItem extends StatelessWidget {
  final MealDetails meals;
  final double rating;
  final String deliveryInfo;
  final double price;
  final VoidCallback onTap;

  const SpecialOfferItem({
    super.key,
    required this.rating,
    required this.deliveryInfo,
    required this.price,
    required this.meals, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFF6B4D),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                meals.strMealThumb ?? "",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      const SizedBox(width: 4),
                      Text(rating.toString(),
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Text(
                    meals.strMeal ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Row(
                    children: [
                      const Icon(Icons.delivery_dining,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(deliveryInfo,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE54630),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Color(0xFFFF6B4D),
                          ),
                        ),
                      ),
                      Text(
                        "\$${price.toStringAsFixed(2)}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
