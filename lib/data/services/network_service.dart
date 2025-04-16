import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../models/category_filter_model.dart';
import '../../models/category_model.dart';
import '../../models/meal_model.dart';

class MealsService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl:"https://www.themealdb.com/api/json/v1/1/",
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
  ))..interceptors.add(PrettyDioLogger());

  Future<List<Categories>?> getCategories() async {
    try {
      final response = await _dio.get("categories.php");
      if (response.statusCode != 200) {
        throw Exception("Failed to load categories");
      } else {
        return CategoryModel.fromJson(response.data).categories;
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<MealDetails>?> getMealsByCategory(String category) async {
    try {
      final response = await _dio.get("filter.php?c=$category");
      if (response.statusCode != 200) {
        throw Exception("Failed to load meals");
      } else {
        return CategoryFilterModel.fromJson(response.data).meals;
      }
    } catch(e) {
      return null;
    }
  }

  Future<List<MealDetails>?> getMealById(String id) async {
    try {
      final response = await _dio.get("lookup.php?i=$id");
      if (response.statusCode != 200) {
        throw Exception("Failed to load meal");
      } else {
        return MealModel.fromJson(response.data).meals;
      }
    }catch(e) {
      return null;
    }
  }
}
