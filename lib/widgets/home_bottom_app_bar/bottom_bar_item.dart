import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? selectedIcon;
  final IconData? notSelectedIcon;
  const BottomBarItem(
      {super.key,
      required this.isSelected,
      required this.onTap,
      this.selectedIcon,
      this.notSelectedIcon});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Icon(
            isSelected ? selectedIcon : notSelectedIcon ?? selectedIcon,
            size: isSelected ? 28 : 26,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : AppTheme.bottomNavButton(context),
          ),
        ),
      ),
    );
  }
}
