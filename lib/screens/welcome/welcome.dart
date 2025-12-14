import 'package:calorie_calculator/screens/onboarding/onboarding.dart';
import 'package:calorie_calculator/screens/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<StatefulWidget> createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  Artboard? artboard;
  StateMachineController? _controller;

  @override
  void initState() {
    super.initState();

    rootBundle.load('assets/animations/sammy_wave.riv').then((data) {
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
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) => Onboarding(),
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
    return WelcomeView(this);
  }
}
