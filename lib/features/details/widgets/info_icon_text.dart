import 'package:flutter/material.dart';

class InfoIconText extends StatelessWidget {
  final String iconPath;
  final String text;

  const InfoIconText({super.key, required this.iconPath, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Image.asset(iconPath, height: 20),
            alignment: PlaceholderAlignment.middle,
          ),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: text,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
