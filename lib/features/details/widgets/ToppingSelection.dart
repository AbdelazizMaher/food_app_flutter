import 'package:flutter/material.dart';

class ToppingsSelection extends StatefulWidget {
  final List<String> ingredients;

  const ToppingsSelection({super.key, required this.ingredients});

  @override
  _ToppingsSelectionState createState() => _ToppingsSelectionState();
}

class _ToppingsSelectionState extends State<ToppingsSelection> {
  String? selectedTopping;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Color(0xFF242731),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Toppings for you",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...widget.ingredients.map((ingredient) {
            final imageUrl = "https://www.themealdb.com/images/ingredients/$ingredient.png";
            return Column(
              children: [
                _buildToppingOption(ingredient, imageUrl),
                const SizedBox(height: 10),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildToppingOption(String value, String imageAsset) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      leading: Image.network(imageAsset, height: 80, width: 80, fit: BoxFit.contain),
      title: Text(
        value,
        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: Radio<String>(
        value: value,
        groupValue: selectedTopping,
        onChanged: (newValue) {
          setState(() {
            selectedTopping = newValue!;
          });
        },
        activeColor: const Color(0xFFFF6B57),
      ),
    );
  }
}
