import 'package:flutter/material.dart';
import 'package:food_app_lab/features/home/widgets/custom_search_bar.dart';
import 'package:food_app_lab/features/home/widgets/section_header.dart';
import '../../models/meal_model.dart' ;
import 'widgets/category_items_view.dart';
import 'widgets/restaurants_items_view.dart';
import 'widgets/special_offer_items_view.dart';

class Home extends StatefulWidget {
   const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<MealDetails>?>? selectedMeals;
  Future<List<MealDetails>?>? selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
              onPressed: (){},
              icon: Image.asset(
                'assets/icons/list.png',
                height: 36,
                width: 36,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: (){},
              iconSize: 100,
              icon: Image.asset(
                'assets/images/person.png',
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Deliver to", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                Image.asset(
                  'assets/icons/location.png',
                  height: 24,
                  width: 24,
                ),
              ]
            ),
            Text("387  Merdina", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))
          ]
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            sliver: SliverList(delegate: SliverChildListDelegate([
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFFE724D), Color(0xFFFFA057)],
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: const Text(
                  "Good Afternoon!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CustomSearchBar(),
              const SizedBox(height: 16),
              CategoryListView(
                onCategorySelected: (futureMeals) {
                  setState(() {
                    selectedMeals = futureMeals;
                  });
                },
              ),
              const SizedBox(height: 16),
              SectionHeader(title: "Special Offers", onViewAll: () {}),
              const SizedBox(height: 16),
              SpecialOfferListView(selectedMeals: selectedMeals),
              const SizedBox(height: 16),
              SectionHeader(title: "Restaurants", onViewAll: () {}),
              const SizedBox(height: 16),
              RestaurantsItemListView(),
            ]))
        ),
        ]
      )
    );
  }
}
