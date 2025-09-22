import 'package:calorie_calculator/screens/onboarding/onboarding_view.dart';
import 'package:calorie_calculator/screens/setup/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Onboarding extends StatefulWidget {
  final ThemeMode themeMode;

  const Onboarding(this.themeMode, {super.key});
  @override
  State<StatefulWidget> createState() => OnboardingState();
}

class OnboardingState extends State<Onboarding> {
  Artboard? artboard;
  StateMachineController? _controller;
  
  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/animations/sammy_idle.riv').then((data) {
      final file = RiveFile.import(data);
      final mainArtboard = file.mainArtboard;

      _controller =
          StateMachineController.fromArtboard(mainArtboard, 'State Machine 1');

      if (_controller != null) {
        mainArtboard.addController(_controller!);
      }

      setState(() => artboard = mainArtboard);
    });
  }

  void onContinueClick() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) =>
            Setup(widget.themeMode),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingView(this);
  }
}
