import 'cart_item.dart';

class CartItemModel {
  final String title;
  final String imagePath;
  final double price;
  final int quantity;

  CartItemModel({required this.title, required this.imagePath, required this.price, required this.quantity});
}

final List<CartItem> cartItems = [
  CartItem(title: 'Pizza margarita European', imagePath: 'assets/images/cart_pizza.png', price: 9.00, quantity: 2, onRemove: () {  }, onIncrease: () {  }, onDecrease: () {  },),
  CartItem(title: 'Spaghetti with shrimp and basil', imagePath: 'assets/images/cart_spaghetti.png', price: 15.30, quantity: 2, onRemove: () {  }, onIncrease: () {  }, onDecrease: () {  },),
];



