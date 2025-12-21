import 'package:calorie_calculator/screens/home/tabs/home_tab.dart';
import 'package:flutter/material.dart';

class MainPageController {
  final Map<String, Widget> _pages = {
    'home': HomeTab(),
    'logs': const Center(child: Text('Logs')),
    'meals': const Center(child: Text('Meals')),
    'profile': const Center(child: Text('Profile')),
  };

  Widget getPage(String pageKey) {
    return _pages[pageKey] ?? const SizedBox.shrink();
  }
}
 