import 'package:calorie_calculator/screens/home/tabs/home_tab.dart';
import 'package:calorie_calculator/screens/home/tabs/meals_tab.dart';
import 'package:flutter/material.dart';

final MainPageController mainPageController = MainPageController();

class MainPageController {
  final GlobalKey<MealsTabState> _mealsTabKey = GlobalKey<MealsTabState>();
  String? _lastPageKey;

  Widget getPage(String pageKey, void Function(String) onPageChanged) {
    if (pageKey == 'meals' && _lastPageKey != 'meals') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mealsTabKey.currentState?.refreshMeals();
      });
    }
    _lastPageKey = pageKey;

    switch (pageKey) {
      case 'home':
        return HomeTab(onPageChanged: onPageChanged);
      case 'logs':
        return const Center(child: Text('Logs'));
      case 'meals':
        return MealsTab(key: _mealsTabKey);
      case 'profile':
        return const Center(child: Text('Profile'));
      default:
        return const SizedBox.shrink();
    }
  }

  void refreshMealsTab() {
    _mealsTabKey.currentState?.refreshMeals();
  }
}
