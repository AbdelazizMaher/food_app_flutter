
import 'package:flutter/material.dart';

import 'restaurants_item.dart';

final List<RestaurantsItem> items = [
  RestaurantsItem(imagePath: "assets/images/large_sushi.png", name: "Seafood maki sushi", delivery: "Free delivery", time: "30 min", rating: 4.5),
  RestaurantsItem(imagePath: "assets/images/large_seafood.png", name: "Pizza Hut", delivery: "Free delivery", time: "30 min", rating: 4.5),
];

class RestaurantsItemListView extends StatelessWidget {
  const RestaurantsItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index];
          }
      ),
    );
  }
}