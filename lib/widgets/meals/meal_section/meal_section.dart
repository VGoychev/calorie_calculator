import 'package:calorie_calculator/models/added_meal_item.dart';
import 'package:calorie_calculator/widgets/meals/meal_card/meal_card.dart';
import 'package:flutter/material.dart';

class MealSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<AddedMealItem> meals;

  const MealSection(
      {super.key,
      required this.title,
      required this.icon,
      required this.meals});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Row(
            children: [
              Icon(icon, color: primaryColor, size: 24),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // Meal Items
        ...meals.map((meal) => MealCard(
              mealItem: meal,
            )),
      ],
    );
  }
}
