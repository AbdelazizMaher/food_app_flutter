part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}
final class DetailsLoading extends DetailsState {
  DetailsLoading();
}
final class DetailsLoaded extends DetailsState {
  final List<MealDetails>? meals;
  DetailsLoaded(this.meals);
}
final class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}
