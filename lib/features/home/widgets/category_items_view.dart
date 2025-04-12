import 'package:flutter/material.dart';
import 'package:food_app_lab/models/meal_model.dart';

import '../../../models/category_filter_model.dart';
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
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return CategoryItem(category: snapshot.data![index], onTap: () {
                        meals = MealsService.getMealsByCategory(snapshot.data![index].strCategory ?? "");
                        widget.onCategorySelected(meals);
                      });
                    }),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
        });

  }
}

