import 'package:flutter/material.dart';
import 'package:food_app_lab/features/cart/widgets/cart_bottom_bar.dart';
import 'package:food_app_lab/features/cart/widgets/cart_item.dart';
import 'package:food_app_lab/features/cart/widgets/cart_item_view.dart';
import '../details/widgets/promo_code.dart';
import 'widgets/cart_summary.dart';

class Cart extends StatelessWidget {
  final String user;
  const Cart({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CartBottomBar(deliveryAddress: "Avinguda Meridiana, 350, 08027, Barcelona", totalPrice: 59.99,),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            floating: true,
            expandedHeight: 80,
            centerTitle: true,
            title: const Text("Cart"),
            leading: Container(
              margin: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/icons/back_arrow.png',
                    height: 24,
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CartItemListView(user: user),
                const SizedBox(height: 16),
                PromoCode(),
                const SizedBox(height: 24),
                const CartSummary(label: "Subtotal", amount: "\$12.20"),
                const Divider(),
                const CartSummary(label: "Tax and Fees", amount: "\$4.10"),
                const Divider(),
                const CartSummary(label: "Delivery", amount: "\$1.00"),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
