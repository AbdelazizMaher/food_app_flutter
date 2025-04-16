import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/db/database_helper.dart';
import '../../../data/repo/meals_repository.dart';
import '../../../data/services/network_service.dart';
import '../../../models/favourite_meal_model.dart';

part 'cart_meal_state.dart';

class CartMealCubit extends Cubit<CartMealState> {
  MealsRepository mealsRepository = MealsRepository.getInstance(MealsService(), DatabaseHelper());

  CartMealCubit() : super(CartMealInitial());

  Future<void> getMeals(String user) async {
    emit(CartMealLoading());
    try {
      final meals = await mealsRepository.getMeals(user);
      emit(CartMealLoaded(meals));
    } catch (e) {
      emit(CartMealError(e.toString()));
    }
  }
}
