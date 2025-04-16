part of 'cart_meal_cubit.dart';

@immutable
sealed class CartMealState {}

final class CartMealInitial extends CartMealState {}
final class CartMealLoading extends CartMealState {
  CartMealLoading();
}
final class CartMealLoaded extends CartMealState {
  final List<FavMeals> meals;
  CartMealLoaded(this.meals);
}
final class CartMealError extends CartMealState {
  final String error;
  CartMealError(this.error);
}

