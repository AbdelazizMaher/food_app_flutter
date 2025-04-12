import 'package:flutter/material.dart';

import '../../../models/category_model.dart';

class CategoryItem extends StatefulWidget {
  final Categories category;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category, required this.onTap,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.category.strCategoryThumb ?? "",
                height: 64,
                width: 64,
                fit: BoxFit.scaleDown,
              ),
            ),
            Text(
              widget.category.strCategory ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
