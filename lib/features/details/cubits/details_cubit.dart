import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/db/database_helper.dart';
import '../../../data/repo/meals_repository.dart';
import '../../../data/services/network_service.dart';
import '../../../models/meal_model.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  MealsRepository mealsRepository = MealsRepository.getInstance(MealsService(), DatabaseHelper());
  DetailsCubit() : super(DetailsInitial());

  Future<void> getMealById(String id) async {
    emit(DetailsLoading());
    try {
      final meals = await mealsRepository.getMealById(id);
      emit(DetailsLoaded(meals));
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }
}
