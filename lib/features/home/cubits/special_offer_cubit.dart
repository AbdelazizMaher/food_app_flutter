import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/db/database_helper.dart';
import '../../../data/repo/meals_repository.dart';
import '../../../data/services/network_service.dart';
import '../../../models/meal_model.dart';

part 'special_offer_state.dart';

class SpecialOfferCubit extends Cubit<SpecialOfferState> {
  MealsRepository mealsRepository = MealsRepository.getInstance(MealsService(), DatabaseHelper());

  SpecialOfferCubit() : super(SpecialOfferInitial());

  Future<void> getMealsByCategory(String category) async {
    emit(SpecialOfferLoading());
    try {
      final meals = await mealsRepository.getMealsByCategory(category);
      emit(SpecialOfferLoaded(meals));
    } catch (e) {
      emit(SpecialOfferError(e.toString()));
    }
  }
}
