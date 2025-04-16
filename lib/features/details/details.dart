import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app_lab/features/details/widgets/AddToBasket.dart';
import 'package:food_app_lab/features/details/widgets/ToppingSelection.dart';
import 'package:food_app_lab/features/details/widgets/expandable_text.dart';
import 'package:food_app_lab/features/details/widgets/info_icon_text.dart';
import 'package:food_app_lab/features/details/widgets/video_player.dart';


import '../../data/db/database_helper.dart';
import '../../models/favourite_meal_model.dart';
import '../../models/meal_model.dart';
import '../../utils/navigation/app_routes.dart';
import 'cubits/details_cubit.dart';

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
  late String user;
  final db = DatabaseHelper();
  FlutterSecureStorage storage = const FlutterSecureStorage();

  late Future<List<MealDetails>?>? meals;
  @override
  void initState() {
    super.initState();
    storage.read(key: 'email').then((value) => user = value!);
    context.read<DetailsCubit>().getMealById(widget.mealId);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        switch (state) {
          case DetailsInitial():
            return Center(child: CircularProgressIndicator());
          case DetailsLoading():
            return Center(child: CircularProgressIndicator());
          case DetailsLoaded():
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
                                    image: NetworkImage(state.meals![0].strMealThumb ?? ""),
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
                              state.meals![0].strMeal ?? "",
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
                        text: state.meals![0].strInstructions ?? "",
                        trimLines: 3,
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                          child: YoutubeVideoPlayer(videoUrl: state.meals![0].strYoutube ?? "")
                      )
                  ),
                  SliverToBoxAdapter(
                    child: ToppingsSelection(
                        ingredients: state.meals![0].getIngredientsList().take(10).toList()),
                  ),
                  SliverToBoxAdapter(child: AddToBasketWidget(onAddToBasket: (int quantity, double totalPrice) {
                    Navigator.of(context).pop();
                    db.insertMeal(FavMeals(user: user, mealName: state.meals![0].strMeal ?? "", imagePath: state.meals![0].strMealThumb ?? "", count: quantity, price: totalPrice));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to basket")));
                    Navigator.pushNamed(context, AppRoutes.cart, arguments: user);
                  },)),
                ],
              ),
            );
          case DetailsError():
            return Center(child: Text(state.message));
        }
      }
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
