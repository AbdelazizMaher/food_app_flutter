import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_lab/models/meal_model.dart';

import '../cubits/category_cubit.dart';
import '../cubits/special_offer_cubit.dart';
import 'category_item.dart';

class CategoryListView extends StatefulWidget {
  final Function(String category) onCategorySelected;
  const CategoryListView({super.key, required this.onCategorySelected});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  String selectedCategory = "Beef";


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state) {
          case CategoryInitial():
            return Center(child: CircularProgressIndicator());
          case CategoryLoading():
            return Center(child: CircularProgressIndicator());
          case CategoryLoaded():
            return  Container(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories?.length,
                  itemBuilder: (context, index) {
                    final category = state.categories![index];
                    return CategoryItem(category: category, onTap: () {
                      setState(() {selectedCategory = category.strCategory ?? "Beef";});
                      context.read<SpecialOfferCubit>().getMealsByCategory(selectedCategory);
                      widget.onCategorySelected(selectedCategory);
                    }, isSelected: selectedCategory == category.strCategory,);
                  }),
            );
          case CategoryError():
            return Center(child: Text(state.message));
        }

      }
    );
  }
}

