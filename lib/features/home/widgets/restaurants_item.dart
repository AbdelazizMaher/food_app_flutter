import 'package:flutter/material.dart';

class RestaurantsItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String delivery;
  final String time;
  final double rating;

  const RestaurantsItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.delivery,
    required this.time,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 12,
                right: 12,
                child: Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),

          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                    const Spacer(),
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(rating.toString(), style: const TextStyle(fontSize: 14))
                  ],
                ),
                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.delivery_dining, size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(delivery, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(width: 12),
                    const Icon(Icons.timer, size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
