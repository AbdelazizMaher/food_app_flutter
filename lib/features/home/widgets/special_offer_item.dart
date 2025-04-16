import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app_lab/models/meal_model.dart';

class SpecialOfferItem extends StatefulWidget {
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
  State<SpecialOfferItem> createState() => _SpecialOfferItemState();
}

class _SpecialOfferItemState extends State<SpecialOfferItem> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = getRandomColor(widget.meals.strMeal ?? "default");
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 320,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: darkenColor(_color, 0.2), width: 2),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: Image.network(
                widget.meals.strMealThumb ?? "",
                width: 100,
                height: 100,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(width: 24),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      const SizedBox(width: 4),
                      Text(widget.rating.toString(),
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Text(
                    widget.meals.strMeal ?? "",
                    maxLines: 1,
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
                      Text(widget.deliveryInfo,
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "\$${widget.price.toStringAsFixed(2)}",
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

  Color getRandomColor(String mealName) {
    final List<Color> colors = [
      Color(0xFFFF6B4D),
      Color(0xFF4D91FF),
      Color(0xFF50C878),
      Color(0xFFFFA500),
      Color(0xFF8A2BE2),
      Color(0xFFFFC107),
      Color(0xFFDB7093),
      Color(0xFFFF69B4),
      Color(0xFFA0522D),
      Color(0xFFCD853F),
      Color(0xFFFF6347),
      Color(0xFF32CD32),
    ];

    final hash = mealName.codeUnits.fold(0, (prev, element) => prev + element);
    return colors[hash % colors.length];
  }

  Color darkenColor(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

}
