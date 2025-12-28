import 'package:calorie_calculator/models/added_meal_item.dart';
import 'package:calorie_calculator/models/food_item.dart';
import 'package:calorie_calculator/models/parsed_food.dart';
import 'package:calorie_calculator/screens/add_meal_manually/add_meal_manually_view.dart';
import 'package:calorie_calculator/services/ai_analyze_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/utils/helpers/text_helper.dart';
import 'package:calorie_calculator/widgets/loading_dialog/loading_dialog.dart';
import 'package:flutter/material.dart';

class AddMealManually extends StatefulWidget {
  const AddMealManually({super.key});

  @override
  State<AddMealManually> createState() => AddMealManuallyState();
}

class AddMealManuallyState extends State<AddMealManually> {
  final TextEditingController textController = TextEditingController();
  final AiAnalyzeService _aiAnalyzeService = AiAnalyzeService();
  List<AddedMealItem>? analyzedMeals;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> analyzeMeal() async {
    final text = textController.text.trim();
    if (text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a meal description')),
        );
      }
      return;
    }

    if (!mounted) return;
    LoadingDialog.show(context);

    try {
      final mealItems = await analyzeMealFirestoreFirst(text);

      // final convertedMeals = await _convertMeals(mealItems);

      if (!mounted) return;
      setState(() {
        analyzedMeals = mealItems;
      });

      LoadingDialog.close(context);
    } catch (e) {
      if (mounted) {
        LoadingDialog.close(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error analyzing meal: ${e.toString()}'),
          ),
        );
      }
    }
  }

  Future<List<AddedMealItem>> analyzeMealFirestoreFirst(
    String input,
  ) async {
    final parsedFoods = TextHelper.parseTextLocally(input);
    final List<AddedMealItem> result = [];
    final List<ParsedFood> missingFoods = [];

    for (final parsed in parsedFoods) {
      final food = await firestoreService.getFoodItemByPartialName(parsed.name);

      if (food == null) {
        missingFoods.add(parsed);
        continue;
      }

      final resolvedQty = _resolveQuantity(parsed, food);

      result.add(
        _toAddedMealItem(food, resolvedQty),
      );
    }

    if (missingFoods.isNotEmpty) {
      final aiItems = await _aiAnalyzeService.analyzeText(
        missingFoods.map((e) => '${e.quantity}${e.unit} ${e.name}').join(', '),
      );

      if (aiItems != null) {
        for (final aiFood in aiItems) {
          await firestoreService.addFoodItem(aiFood);
          result.add(
            _toAddedMealItem(
              aiFood,
              aiFood.exampleQuantity,
            ),
          );
        }
      }
    }

    return result;
  }

  int _resolveQuantity(ParsedFood parsed, FoodItem food) {
    if (parsed.unit == 'g' || parsed.unit == 'ml') {
      return parsed.quantity;
    }

    return parsed.quantity * food.exampleQuantity;
  }

  AddedMealItem _toAddedMealItem(FoodItem food, int quantity) {
    return AddedMealItem(
      name: food.name,
      quantity: quantity,
      calories: (food.caloriesPer100 * quantity / 100).round(),
      proteins: (food.proteinPer100 * quantity / 100).round(),
      carbs: (food.carbsPer100 * quantity / 100).round(),
      fats: (food.fatsPer100 * quantity / 100).round(),
    );
  }

  void resetAndAnalyzeAgain() {
    setState(() {
      analyzedMeals = null;
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AddMealManuallyView(this);
  }
}
