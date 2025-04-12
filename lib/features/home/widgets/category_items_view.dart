import 'package:flutter/material.dart';
import 'package:food_app_lab/models/meal_model.dart';

import '../../../models/category_model.dart';
import '../../../services/network_service.dart';
import 'category_item.dart';

class CategoryListView extends StatefulWidget {
  final Function(Future<List<MealDetails>?>? meals) onCategorySelected;
  const CategoryListView({super.key, required this.onCategorySelected});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  late Future<List<Categories>?>? categories;
  late Future<List<MealDetails>?>? meals;
  String selectedCategory = "Beef";


  @override
  void initState() {
    super.initState();
    categories = MealsService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: categories,
        builder: (context, snapshot){
            if (snapshot.hasData) {
              return Container(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      final category = snapshot.data![index];
                      return CategoryItem(category: category, onTap: () {
                        setState(() {selectedCategory = category.strCategory ?? "Beef";});
                        meals = MealsService.getMealsByCategory(snapshot.data![index].strCategory ?? "Beef");
                        widget.onCategorySelected(meals);
                      }, isSelected: selectedCategory == category.strCategory,);
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
        });

  }
}

