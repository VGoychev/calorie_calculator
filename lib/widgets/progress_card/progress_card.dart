import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:calorie_calculator/widgets/circle_progress_stack/circle_progress_stack.dart';
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final VoidCallback onTap;
  const ProgressCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Color(0xFF1a1a1a),
                      Color(0xFF121212),
                    ]
                  : [
                      Color(0xFFfafafa),
                      Color(0xFFf5f5f5),
                    ],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withAlpha(120)
                    : Colors.black.withAlpha(120),
                blurRadius: 6,
                offset: Offset(4, 4),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: Theme.of(context).primaryColor.withAlpha(20),
                blurRadius: 15,
                offset: Offset(0, -3),
                spreadRadius: -5,
              ),
            ],
            border: Border.all(
              color: isDark ? primaryColor : AppTheme.lighterGreen,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 12, 6),
            child: Row(
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
                      _buildNutrientRow(
                          Colors.green, 'Carbohydrates', '150/210 g', context),
                      SizedBox(height: 8),
                      _buildNutrientRow(
                          AppTheme.purple, 'Fats', '60/88 g', context),
                    ],
                  ),
                )
              ],
            ),
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
