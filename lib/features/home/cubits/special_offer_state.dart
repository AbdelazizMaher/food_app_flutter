part of 'special_offer_cubit.dart';

@immutable
sealed class SpecialOfferState {}

final class SpecialOfferInitial extends SpecialOfferState {}
final class SpecialOfferLoading extends SpecialOfferState {
  SpecialOfferLoading();
}
final class SpecialOfferLoaded extends SpecialOfferState {
  final List<MealDetails>? meals;
  SpecialOfferLoaded(this.meals);
}
final class SpecialOfferError extends SpecialOfferState {
  final String message;
  SpecialOfferError(this.message);
}

