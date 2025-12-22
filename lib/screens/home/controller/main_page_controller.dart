import 'package:calorie_calculator/screens/home/tabs/home_tab.dart';
import 'package:flutter/material.dart';

final MainPageController mainPageController = MainPageController();

class MainPageController {
  Widget getPage(String pageKey, void Function(String) onPageChanged) {
    switch (pageKey) {
      case 'home':
        return HomeTab(onPageChanged: onPageChanged);
      case 'logs':
        return const Center(child: Text('Logs'));
      case 'meals':
        return const Center(child: Text('Meals'));
      case 'profile':
        return const Center(child: Text('Profile'));
      default:
        return const SizedBox.shrink();
    }
  }
}
