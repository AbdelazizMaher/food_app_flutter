import 'package:flutter/material.dart';

import '../../../models/category_model.dart';

class CategoryItem extends StatefulWidget {
  final Categories category;
  final VoidCallback onTap;
  final bool isSelected;

  const CategoryItem({
    super.key,
    required this.category, required this.onTap, required this.isSelected,
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xFF50C878).withOpacity(0.6) : Colors.transparent,
            borderRadius: widget.isSelected ? BorderRadius.circular(40) : BorderRadius.circular(0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.network(
                    widget.category.strCategoryThumb ?? "",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.category.strCategory ?? "",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
