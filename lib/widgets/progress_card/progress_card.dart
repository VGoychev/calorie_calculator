import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:calorie_calculator/widgets/circle_progress_stack/circle_progress_stack.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final VoidCallback? onTap;
  final bool includeMealsNavigator;
  const ProgressCard(
      {super.key, this.onTap, this.includeMealsNavigator = true});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: includeMealsNavigator
          ? EdgeInsetsGeometry.fromLTRB(8, 4, 8, 8)
          : EdgeInsets.zero,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: AppTheme.homeContainerDecoration(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleProgressStack(),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNutrientRow(AppTheme.red, 'Calories',
                            '1,200/1,800 kcal', context),
                        SizedBox(height: 8),
                        _buildNutrientRow(
                            AppTheme.blue, 'Proteins', '80/120 g', context),
                        SizedBox(height: 8),
                        _buildNutrientRow(Colors.green, 'Carbohydrates',
                            '150/210 g', context),
                        SizedBox(height: 8),
                        _buildNutrientRow(
                            AppTheme.purple, 'Fats', '60/88 g', context),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              if (includeMealsNavigator)
                GestureDetector(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white12
                            : AppTheme.lighterGreen.withAlpha(45),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "View Meals",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Today's meals",
                            style: TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: primaryColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNutrientRow(
      Color color, String label, String value, BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: color),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    );
  }
}
