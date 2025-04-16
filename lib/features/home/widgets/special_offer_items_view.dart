
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/meal_model.dart' ;
import '../../details/cubits/details_cubit.dart';
import '../../details/details.dart';
import '../cubits/special_offer_cubit.dart';
import 'special_offer_item.dart';


class SpecialOfferListView extends StatefulWidget {
  String selectedCategory;
  SpecialOfferListView({super.key, required this.selectedCategory});

  @override
  State<SpecialOfferListView> createState() => _SpecialOfferListViewState();
}

class _SpecialOfferListViewState extends State<SpecialOfferListView> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialOfferCubit, SpecialOfferState>(
      builder: (context, state) {
        switch (state) {
          case SpecialOfferInitial():
            return Center(child: CircularProgressIndicator());
          case SpecialOfferLoading():
            return Center(child: CircularProgressIndicator());
          case SpecialOfferLoaded():
            return Container(
              height: 160,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.meals?.length,
                  itemBuilder: (context, index) => SpecialOfferItem(meals: state.meals![index], rating: 4.5, deliveryInfo: "Free delivery", price: 12.99, onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return BlocProvider(
  create: (context) => DetailsCubit(),
  child: DraggableScrollableSheet(
                          initialChildSize: 0.6,
                          minChildSize: 0.3,
                          maxChildSize: 0.95,
                          expand: false,
                          builder: (context, scrollController) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                              ),
                              child: Details(
                                mealId: state.meals![index].idMeal ?? "",
                                delivery: "Free delivery",
                                time: "30 mins",
                                rating: "4.5",
                                scrollController: scrollController,
                              ),
                            );
                          },
                        ),
);
                      },
                    );
                  }
                  )),
            );
          case SpecialOfferError():
            return Center(child: Text(state.message));
        }
      }
    );
  }
}