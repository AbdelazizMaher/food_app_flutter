import 'package:flutter/material.dart';
import 'package:food_app_lab/features/cart/widgets/quantity_control.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final double price;
  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItem({
    super.key,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.quantity,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imagePath, height: 100, width: 100, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(flex: 2, child: Text(title, softWrap: true, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  const Spacer(),
                  IconButton(onPressed: onRemove, icon: const Icon(Icons.close, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text("\$${price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                  const Spacer(),
                  QuantityControl(initialQuantity: quantity, onIncrease: onIncrease, onDecrease: onDecrease),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
