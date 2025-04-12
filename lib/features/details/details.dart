import 'package:flutter/material.dart';
import 'package:food_app_lab/features/details/widgets/AddToBasket.dart';
import 'package:food_app_lab/features/details/widgets/ToppingSelection.dart';
import 'package:food_app_lab/features/details/widgets/expandable_text.dart';
import 'package:food_app_lab/features/details/widgets/info_icon_text.dart';
import 'package:food_app_lab/features/details/widgets/video_player.dart';

import '../../models/meal_model.dart';
import '../../services/network_service.dart';

class Details extends StatefulWidget {
  final String mealId;
  final String delivery;
  final String time;
  final String rating;
  final ScrollController scrollController;

  const Details({
    super.key,
    required this.delivery,
    required this.time,
    required this.rating, required this.mealId, required this.scrollController,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Future<List<MealDetails>?>? meals;
  @override
  void initState() {
    super.initState();
    meals = MealsService.getMealById(widget.mealId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: meals,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: CustomScrollView(
              controller: widget.scrollController,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 250,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 25,
                          right: 25,
                          top: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(Icons.clear)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite)),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data![0].strMealThumb ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            snapshot.data![0].strMeal ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "\$${widget.rating}",
                          style: TextStyle(
                              color: Color(0xFFFF6B57),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const InfoIconText(iconPath: "assets/images/truck.png", text: "Free delivery"),
                        SizedBox(width: 20),
                        InfoIconText(iconPath: "assets/images/clock.png", text: widget.time),
                        SizedBox(width: 40),
                        InfoIconText(iconPath: "assets/images/star.png", text: "${widget.rating}"),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: ExpandableText(
                      text: snapshot.data![0].strInstructions ?? "",
                      trimLines: 3,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: YoutubeVideoPlayer(videoUrl: snapshot.data![0].strYoutube ?? "")
                  )
                ),
                SliverToBoxAdapter(
                  child: ToppingsSelection(
                    ingredients: snapshot.data![0].getIngredientsList().take(10).toList()),
                ),
                SliverToBoxAdapter(child: AddToBasketWidget()),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }
}

extension on MealDetails {
  List<String> getIngredientsList() {
    List<String> ingredients = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = this.toJson()["strIngredient$i"];
      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          ingredient.toString().toLowerCase() != "null") {
        final formatted = ingredient.toString().trim().trim();
        ingredients.add(formatted);
      }
    }

    return ingredients;
  }
}
