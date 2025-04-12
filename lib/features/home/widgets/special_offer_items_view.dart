
import 'package:flutter/material.dart';

import '../../../models/meal_model.dart' ;
import '../../../services/network_service.dart';
import '../../details/details.dart';
import 'special_offer_item.dart';


class SpecialOfferListView extends StatefulWidget {
  Future<List<MealDetails>?>? selectedMeals;
  SpecialOfferListView({super.key, required this.selectedMeals});

  @override
  State<SpecialOfferListView> createState() => _SpecialOfferListViewState();
}

class _SpecialOfferListViewState extends State<SpecialOfferListView> {

  @override
  void initState() {
    super.initState();
    widget.selectedMeals = MealsService.getMealsByCategory("Beef");
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: widget.selectedMeals,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) => SpecialOfferItem(meals: snapshot.data![index], rating: 4.5, deliveryInfo: "Free delivery", price: 12.99, onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return DraggableScrollableSheet(
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
                                mealId: snapshot.data![index].idMeal ?? "",
                                delivery: "Free delivery",
                                time: "30 mins",
                                rating: "4.5",
                                scrollController: scrollController,
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  )),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}