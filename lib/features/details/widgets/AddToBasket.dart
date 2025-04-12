import 'package:flutter/material.dart';

class AddToBasketWidget extends StatefulWidget {
  const AddToBasketWidget({super.key});

  @override
  State<AddToBasketWidget> createState() => _AddToBasketWidgetState();
}

class _AddToBasketWidgetState extends State<AddToBasketWidget> {
  int quantity = 1;
  double pricePerItem = 11.17;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = (pricePerItem * quantity);

    return Expanded(
      child: Container(
        color: const Color(0xFF18191D),
        width: double.maxFinite,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: decreaseQuantity,
                  icon: const Icon(Icons.remove, color: Colors.black, size: 20),
                ),
              ),
            ),
            Text("$quantity", style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: increaseQuantity,
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 220,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("$quantity added to basket"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Text(
                    "Add $quantity to basket   \$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
