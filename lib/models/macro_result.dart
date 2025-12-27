import 'package:calorie_calculator/models/food_item.dart';

class MacroResult {
  final double calories;
  final double protein;
  final double carbs;
  final double fats;

  MacroResult(
      {required this.calories,
      required this.protein,
      required this.carbs,
      required this.fats});
}

MacroResult calculateForExampleQuantity(FoodItem foodItem) {
  double factor = foodItem.exampleQuantity / 100.0;

  double calories = foodItem.caloriesPer100 * factor;
  double protein = foodItem.proteinPer100 * factor;
  double carbs = foodItem.carbsPer100 * factor;
  double fats = foodItem.fatsPer100 * factor;

  return MacroResult(
      calories: calories.roundToDouble(),
      protein: protein.roundToDouble(),
      carbs: carbs.roundToDouble(),
      fats: fats.roundToDouble());
}
