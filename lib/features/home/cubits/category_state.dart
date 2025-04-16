part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}
final class CategoryLoading extends CategoryState {
  CategoryLoading();
}

final class CategoryLoaded extends CategoryState {
  final List<Categories>? categories;
  final List<MealDetails>? meals;
  CategoryLoaded(this.categories, this.meals);
}

final class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}

