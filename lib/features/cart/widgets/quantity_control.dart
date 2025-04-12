import 'package:flutter/material.dart';

class QuantityControl extends StatefulWidget {
  final int initialQuantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const QuantityControl({
    super.key,
    required this.initialQuantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  _QuantityControlState createState() => _QuantityControlState();
}

class _QuantityControlState extends State<QuantityControl> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFD3D1D8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 14,
              onPressed: () {
                setState(() {
                  _quantity--;
                });
                widget.onDecrease();
              },
              icon: const Icon(Icons.remove),
            ),
          ),
        ),
        Text(_quantity.toString()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: const BoxDecoration(
              color: Color(0xFFD3D1D8),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              iconSize: 14,
              onPressed: () {
                setState(() {
                  _quantity++;
                });
                widget.onIncrease();
              },
              icon: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
