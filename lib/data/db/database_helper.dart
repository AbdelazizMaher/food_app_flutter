import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../models/favourite_meal_model.dart';


class DatabaseHelper {
  static Database? _database;
  final String tableName = 'favs';
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'favourite_meals.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(user TEXT, mealName TEXT, imagePath TEXT, count INTEGER, price REAL, PRIMARY KEY(user, mealName))',
        );
      });
  }

  Future<int> insertMeal(FavMeals meal) async {
    final db = await database;
    return await db.insert(tableName, meal.toJson());
  }

  Future<int> updateMeal(String user, String mealName, int newCount, double newPrice) async {
    final db = await database;
    return await db.update(
      tableName,
        {
          'count': newCount,
          'price': newPrice,
        },
      where: 'user = ? AND mealName = ?',
      whereArgs: [user, mealName]);
  }

  Future<int> deleteMeal(String user, String mealName) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'user = ? AND mealName = ?',
      whereArgs: [user, mealName]);
  }

  Future<List<FavMeals>> getMeals(String user) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName, where: 'user = ?', whereArgs: [user]);
    return List.generate(maps.length, (index){
      return FavMeals.fromJson(maps[index]);
    });
  }
}