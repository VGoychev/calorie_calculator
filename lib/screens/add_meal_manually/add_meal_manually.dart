import 'package:calorie_calculator/models/added_meal_item.dart';
import 'package:calorie_calculator/models/meal_item.dart';
import 'package:calorie_calculator/screens/add_meal_manually/add_meal_manually_view.dart';
import 'package:calorie_calculator/services/ai_analyze_service.dart';
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
      final mealItem = await _aiAnalyzeService.analyzeText(text);

      if (!mounted) return;

      final mealItems = await _aiAnalyzeService.analyzeText(text);

      if (mealItems == null || mealItems.isEmpty) {
        return;
      }

      setState(() {
        analyzedMeals = _convertMeals(mealItems);
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

  List<AddedMealItem> _convertMeals(List<MealItem> meals) {
    return meals.map((meal) {
      final grams = meal.foods.first.quantity.round();

      return AddedMealItem(
        name: meal.name,
        grams: grams,
        calories: meal.calories.round(),
        proteins: meal.protein.round(),
        fats: meal.fats.round(),
        carbs: meal.carbs.round(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AddMealManuallyView(this);
  }
}
