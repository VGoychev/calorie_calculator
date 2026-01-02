import 'package:calorie_calculator/models/user_meal_entry.dart';
import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final UserMealEntry mealEntry;

  const MealCard({
    super.key,
    required this.mealEntry,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [Color(0xFF1a1a1a), Color(0xFF121212)]
              : [Color(0xFFfafafa), Color(0xFFf5f5f5)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
        border: Border.all(
          color: isDark ? primaryColor.withAlpha(100) : AppTheme.lighterGreen,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meal name and grams
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    mealEntry.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${mealEntry.quantity}g',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Nutritional info
            Row(
              children: [
                _buildNutrientChip(
                  context,
                  AppTheme.red,
                  '${(mealEntry.caloriesPer100 * mealEntry.quantity / 100).round()} kcal',
                ),
                SizedBox(width: 8),
                _buildNutrientChip(
                  context,
                  AppTheme.blue,
                  'P: ${(mealEntry.proteinPer100 * mealEntry.quantity / 100).round()}g',
                ),
                SizedBox(width: 8),
                _buildNutrientChip(
                  context,
                  Colors.green,
                  'C: ${(mealEntry.carbsPer100 * mealEntry.quantity / 100).round()}g',
                ),
                SizedBox(width: 8),
                _buildNutrientChip(
                  context,
                  AppTheme.purple,
                  'F: ${(mealEntry.fatsPer100 * mealEntry.quantity / 100).round()}g',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientChip(BuildContext context, Color color, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? color.withAlpha(40) : color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
