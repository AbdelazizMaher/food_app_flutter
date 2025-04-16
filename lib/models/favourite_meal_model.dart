class FavMeals {
  final String user;
  final String mealName;
  final String imagePath;
  final int count;
  final double price;

  FavMeals({
    required this.user,
    required this.mealName,
    required this.imagePath,
    required this.count,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'mealName': mealName,
      'imagePath': imagePath,
      'count': count,
      'price': price,
    };
  }

  factory FavMeals.fromJson(Map<String, dynamic> map) {
    return FavMeals(
      user: map['user'],
      mealName: map['mealName'],
      imagePath: map['imagePath'],
      count: map['count'],
      price: map['price'],
    );
  }
}
