import 'package:calorie_calculator/models/food_item.dart';
import 'package:calorie_calculator/models/parsed_food.dart';
import 'package:calorie_calculator/models/user_meal_entry.dart';
import 'package:calorie_calculator/screens/add_meal_manually/add_meal_manually_view.dart';
import 'package:calorie_calculator/services/ai_analyze_service.dart';
import 'package:calorie_calculator/services/auth_service.dart';
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
  List<Map<String, dynamic>>? analyzedMeals; 
  String selectedMealType = 'breakfast'; 

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

  Future<List<Map<String, dynamic>>> analyzeMealFirestoreFirst(
    String input,
  ) async {
    final parsedFoods = TextHelper.parseTextLocally(input);
    final List<Map<String, dynamic>> result = [];
    final List<ParsedFood> missingFoods = [];

    for (final parsed in parsedFoods) {
      final food = await firestoreService.getFoodItemByPartialName(parsed.name);

      if (food == null) {
        missingFoods.add(parsed);
        continue;
      }

      final resolvedQty = _resolveQuantity(parsed, food);

      result.add({
        'foodItem': food,
        'quantity': resolvedQty,
      });
    }

    if (missingFoods.isNotEmpty) {
      final aiItems = await _aiAnalyzeService.analyzeText(
        missingFoods.map((e) => '${e.quantity}${e.unit} ${e.name}').join(', '),
      );

      if (aiItems != null) {
        for (final aiFood in aiItems) {
          await firestoreService.addFoodItem(aiFood);
          result.add({
            'foodItem': aiFood,
            'quantity': aiFood.exampleQuantity,
          });
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


  void resetAndAnalyzeAgain() {
    setState(() {
      analyzedMeals = null;
      textController.clear();
    });
  }

  void updateMealType(String mealType) {
    setState(() {
      selectedMealType = mealType;
    });
  }

  Future<void> confirmAndAddMeals(BuildContext context) async {
    if (analyzedMeals == null || analyzedMeals!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No meals to add')),
        );
      }
      return;
    }

    if (!mounted) return;
    LoadingDialog.show(context);

    try {
      final uid = await authService.getCurrentUserId();
      if (uid.isEmpty) {
        if (mounted) {
          LoadingDialog.close(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please log in to add meals')),
          );
        }
        return;
      }

      final mealEntries = analyzedMeals!.map((meal) {
        final foodItem = meal['foodItem'] as FoodItem;
        final quantity = meal['quantity'] as int;
        return UserMealEntry.fromFoodItem(
          foodItem: foodItem,
          quantity: quantity,
        );
      }).toList();

      await firestoreService.addMeals(
        uid: uid,
        date: DateTime.now(),
        mealType: selectedMealType,
        meals: mealEntries,
      );

      if (!mounted) return;
      LoadingDialog.close(context);

      Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        LoadingDialog.close(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding meals: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddMealManuallyView(this);
  }
}
