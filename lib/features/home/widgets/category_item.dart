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
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xFF50C878).withOpacity(0.2) : Colors.transparent,
            borderRadius: widget.isSelected ? BorderRadius.circular(36) : BorderRadius.circular(0),
            border: widget.isSelected
                ? Border.all(color: Color(0xFF50C878), width: 2)
                : null,
          ),
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
      ),
    );
  }
}
