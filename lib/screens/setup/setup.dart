import 'package:calorie_calculator/screens/setup/setup_view.dart';
import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  final ThemeMode themeMode;

  const Setup(this.themeMode, {super.key});

  @override
  State<StatefulWidget> createState() => SetupState();
}

class SetupState extends State<Setup> {
  late int weightInt;
  late int weightFraction;
  late int height;
  late String activityLevel;
  late int age;

  final pageController = PageController(initialPage: 0, viewportFraction: 1);

  @override
  Widget build(BuildContext context) {
    return SetupView(this);
  }
}
