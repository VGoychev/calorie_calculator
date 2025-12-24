import 'package:calorie_calculator/models/food_item.dart';

class MealItem {
  final String id;
  final String name;
  final DateTime date;

  final double calories;
  final double protein;
  final double carbs;
  final double fats;

  final List<FoodItem> foods;

  MealItem({
    required this.id,
    required this.name,
    required this.date,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.foods,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fats': fats,
        'foods': foods.map((f) => f.toJson()).toList(),
      };

  factory MealItem.fromJson(Map<String, dynamic> json) {
    return MealItem(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fats: json['fats'],
      foods: (json['foods'] as List).map((f) => FoodItem.fromJson(f)).toList(),
    );
  }
}

List<MealItem> createMealFromAI({
  required String userInput,
  required Map<String, dynamic> aiResponse,
}) {
  final foods =
      (aiResponse['foods'] as List).map((f) => FoodItem.fromJson(f)).toList();

  return foods.map((food) {
    return MealItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: food.name,
      date: DateTime.now(),
      calories: food.calories,
      protein: food.protein,
      carbs: food.carbs,
      fats: food.fats,
      foods: [food],
    );
  }).toList();
}
