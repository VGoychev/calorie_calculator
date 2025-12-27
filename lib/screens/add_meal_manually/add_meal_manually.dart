import 'package:calorie_calculator/models/added_meal_item.dart';
import 'package:calorie_calculator/models/food_item.dart';
import 'package:calorie_calculator/models/macro_result.dart';
import 'package:calorie_calculator/screens/add_meal_manually/add_meal_manually_view.dart';
import 'package:calorie_calculator/services/ai_analyze_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
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
      final mealItems = await _aiAnalyzeService.analyzeText(text);

      if (mealItems == null || mealItems.isEmpty) {
        if (!mounted) return;
        LoadingDialog.close(context);
        return;
      }

      final convertedMeals = await _convertMeals(mealItems);

      if (!mounted) return;
      setState(() {
        analyzedMeals = convertedMeals;
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

  void resetAndAnalyzeAgain() {
    setState(() {
      analyzedMeals = null;
      textController.clear();
    });
  }

  Future<List<AddedMealItem>> _convertMeals(List<FoodItem> foodItems) async {
    return foodItems.map((foodItem) {
      final macroResult = calculateForExampleQuantity(foodItem);

      _addFoodItemToFirebase(foodItem);

      return AddedMealItem(
        name: foodItem.name,
        quantity: foodItem.exampleQuantity,
        calories: macroResult.calories.round(),
        proteins: macroResult.protein.round(),
        fats: macroResult.fats.round(),
        carbs: macroResult.carbs.round(),
      );
    }).toList();
  }

  void _addFoodItemToFirebase(FoodItem foodItem) async {
    FoodItem? item = await firestoreService.getFoodItemByName(foodItem.name);
    if (item == null) {
      await firestoreService.addFoodItem(foodItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddMealManuallyView(this);
  }
}
