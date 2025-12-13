import 'package:calorie_calculator/screens/setup/setup_view.dart';
import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  final ThemeMode themeMode;

  const Setup(this.themeMode, {super.key});

  @override
  State<StatefulWidget> createState() => SetupState();
}

class SetupState extends State<Setup> {
  int weightInt = 75;
  int weightFraction = 0;
  int height = 170;
  String activityLevel = 'Sedentary';
  int age = 18;
  String gender = 'Male';

  final pageController = PageController(initialPage: 0, viewportFraction: 1);

  void setGender(String gender) {
    setState(() {
      this.gender = gender;
    });
  }

  void setHeight(int height) {
    setState(() {
      this.height = height;
    });
  }

  void setWeight(int weightInt) {
    setState(() {
      this.weightInt = weightInt;
    });
  }

  void setWeightFraction(int weightFraction) {
    setState(() {
      this.weightFraction = weightFraction;
    });
  }

  void setAge(int age) {
    setState(() {
      this.age = age;
    });
  }

  void setActivityLevel(String activityLevel) {
    setState(() {
      this.activityLevel = activityLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SetupView(this);
  }
}
