import 'package:calorie_calculator/models/added_meal_item.dart';
import 'package:calorie_calculator/widgets/meals/meal_section/meal_section.dart';
import 'package:calorie_calculator/widgets/progress_card/progress_card.dart';
import 'package:flutter/material.dart';

class MealsTab extends StatefulWidget {
  const MealsTab({super.key});

  @override
  State<MealsTab> createState() => _MealsTabState();
}

class _MealsTabState extends State<MealsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          ProgressCard(
            includeMealsNavigator: false,
          ),
          SizedBox(height: 12),
          // Breakfast Section
          Expanded(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              SizedBox(height: 12),

              MealSection(
                title: 'Breakfast',
                icon: Icons.wb_sunny_outlined,
                meals: [
                  AddedMealItem(
                    name: 'Oatmeal with Berries',
                    quantity: 250,
                    calories: 320,
                    proteins: 12,
                    fats: 8,
                    carbs: 52,
                  ),
                  AddedMealItem(
                    name: 'Greek Yogurt',
                    quantity: 150,
                    calories: 180,
                    proteins: 15,
                    fats: 6,
                    carbs: 18,
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Lunch Section
              MealSection(
                title: 'Lunch',
                icon: Icons.lunch_dining_outlined,
                meals: [
                  AddedMealItem(
                    name: 'Grilled Chicken Salad',
                    quantity: 350,
                    calories: 420,
                    proteins: 38,
                    fats: 18,
                    carbs: 28,
                  ),
                  AddedMealItem(
                    name: 'Whole Grain Bread',
                    quantity: 60,
                    calories: 160,
                    proteins: 6,
                    fats: 2,
                    carbs: 30,
                  ),
                ],
              ),

              SizedBox(height: 16),

              // Dinner Section
              MealSection(
                title: 'Dinner',
                icon: Icons.dinner_dining_outlined,
                meals: [
                  AddedMealItem(
                    name: 'Salmon with Vegetables',
                    quantity: 280,
                    calories: 380,
                    proteins: 32,
                    fats: 22,
                    carbs: 15,
                  ),
                ],
              ),
            ],
          ))),
        ],
      ),
    );
  }
}
