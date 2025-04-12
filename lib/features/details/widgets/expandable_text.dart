import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 2,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: LayoutBuilder(
        builder: (context, size) {
          final span = TextSpan(
            text: widget.text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          );
          final tp = TextPainter(
            text: span,
            maxLines: widget.trimLines,
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: size.maxWidth);

          final isOverflowing = tp.didExceedMaxLines;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: _expanded ? null : widget.trimLines,
                overflow:
                _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              if (isOverflowing)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _expanded ? "Show less" : "Read more",
                    style: TextStyle(
                      color: Color(0xFFFF6B57),
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
