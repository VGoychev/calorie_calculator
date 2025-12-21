import 'dart:developer' as developer;

import 'package:calorie_calculator/screens/setup/setup_view.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/widgets/loading_dialog/loading_dialog.dart';
import 'package:flutter/material.dart';

class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<StatefulWidget> createState() => SetupState();
}

class SetupState extends State<Setup> {
  double? activityMultiplier;
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

  Future<void> onFinishSetup() async {
    final userId = await authService.getCurrentUserId();
    final user = await firestoreService.getUserById(userId);
    try {
      if (user != null) {
        activityMultiplier = user.activityLevelToDouble(activityLevel);
        await firestoreService.updateUser(
          userId,
          {
            'weight': weightInt + weightFraction / 10.0,
            'height': height.toDouble(),
            'age': age,
            'gender': gender,
            'activity_level': activityMultiplier,
          },
        );
        if (!mounted) return;
        LoadingDialog.show(context);
        await Future.delayed(Duration(milliseconds: 2000));
        if (!mounted) return;
        LoadingDialog.close(context);
        if (!mounted) return;
        await Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      developer.log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SetupView(this);
  }
}
