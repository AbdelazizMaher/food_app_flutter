import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_lab/features/cart/cubit/cart_meal_cubit.dart';

import '../../../data/db/database_helper.dart';
import 'cart_item.dart';

class CartItemListView extends StatefulWidget {
  final String user;
  const CartItemListView({super.key, required this.user});

  @override
  State<CartItemListView> createState() => _CartItemListViewState();
}

class _CartItemListViewState extends State<CartItemListView> {
  final DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartMealCubit, CartMealState>(
        builder: (context, state) {
          switch (state) {

            case CartMealInitial():
              return Center(child: CircularProgressIndicator());
            case CartMealLoading():
              return Center(child: CircularProgressIndicator());
            case CartMealLoaded():
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: state.meals.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartItem(title: state.meals[index].mealName, imagePath: state.meals[index].imagePath, price: state.meals[index].price, quantity: state.meals[index].count,
                      onRemove: () {
                        db.deleteMeal(widget.user, state.meals[index].mealName);
                        context.read<CartMealCubit>().getMeals(widget.user);
                        setState(() {});
                      },
                      onIncrease: () {
                        db.updateMeal(widget.user, state.meals[index].mealName, state.meals[index].count + 1, state.meals[index].price);
                      },
                      onDecrease: () {
                        db.updateMeal(widget.user, state.meals[index].mealName, state.meals[index].count - 1, state.meals[index].price);
                      }
                  );
                },

              );
            case CartMealError():
              return Center(child: Text(state.error));
          }
        });
  }
}






