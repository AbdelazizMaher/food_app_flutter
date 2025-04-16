

import 'package:food_app_lab/data/services/network_service.dart';

import '../../models/category_model.dart';
import '../../models/favourite_meal_model.dart';
import '../../models/meal_model.dart';
import '../db/database_helper.dart';

class MealsRepository {
  final MealsService mealsService;
  final DatabaseHelper databaseHelper;
  MealsRepository({required this.mealsService, required this.databaseHelper});

  static MealsRepository? _instance;

  static MealsRepository getInstance(MealsService mealsService, DatabaseHelper databaseHelper) {
    _instance ??= MealsRepository(mealsService: mealsService, databaseHelper: databaseHelper);
    return _instance!;
  }

  Future<List<Categories>?> getCategories() async {
    return await mealsService.getCategories();
  }

  Future<List<MealDetails>?> getMealsByCategory(String category) async {
    return await mealsService.getMealsByCategory(category);
  }

  Future<List<MealDetails>?> getMealById(String id) async {
    return await mealsService.getMealById(id);
  }

  Future<int> insertMeal(FavMeals meal) async {
    return await databaseHelper.insertMeal(meal);
  }

  Future<int> updateMeal(String user, String mealName, int newCount, double newPrice) async {
    return await databaseHelper.updateMeal(user, mealName, newCount, newPrice);
  }

  Future<int> deleteMeal(String user, String mealName) async {
    return await databaseHelper.deleteMeal(user, mealName);
  }

  Future<List<FavMeals>> getMeals(String user) async {
    return await databaseHelper.getMeals(user);
  }
}