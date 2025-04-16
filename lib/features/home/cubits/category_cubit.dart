import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../../data/db/database_helper.dart';
import '../../../data/repo/meals_repository.dart';
import '../../../data/services/network_service.dart';
import '../../../models/category_model.dart';
import '../../../models/meal_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  MealsRepository mealsRepository = MealsRepository.getInstance(MealsService(), DatabaseHelper());
  CategoryCubit() : super(CategoryInitial());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await mealsRepository.getCategories();
      final meals = await mealsRepository.getMealsByCategory("Beef");

      emit(CategoryLoaded(categories, meals));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
