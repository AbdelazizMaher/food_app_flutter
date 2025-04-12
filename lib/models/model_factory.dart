import 'category_filter_model.dart';
import 'category_model.dart';
import 'meal_model.dart';

abstract class JsonFactory<T> {
  T fromJson(Map<String, dynamic> json);
}

class ModelFactory {
  static T? fromJson<T>(Map<String, dynamic> json) {
    switch (T) {
      case CategoryModel:
        return CategoryModel().fromJson(json) as T;
      case MealModel:
        return MealModel().fromJson(json) as T;
      case CategoryFilterModel:
        return CategoryFilterModel().fromJson(json) as T;
      default:
        throw Exception("");
    }
  }
}
