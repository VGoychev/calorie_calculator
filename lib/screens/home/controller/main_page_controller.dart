import 'package:flutter/material.dart';

class MainPageController {
  final Map<String, Widget> _pages = {
    'home': const Center(child: Text('Home')),
    'logs': const Center(child: Text('Logs')),
    'meals': const Center(child: Text('Meals')),
    'profile': const Center(child: Text('Profile')),
  };

  Widget getPage(String pageKey) {
    return _pages[pageKey] ?? const SizedBox.shrink();
  }
}
