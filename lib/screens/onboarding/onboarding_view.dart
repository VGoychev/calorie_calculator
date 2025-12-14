import 'package:calorie_calculator/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class OnboardingView extends StatelessWidget {
  final OnboardingState state;

  const OnboardingView(this.state, {super.key});
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  color:
                      isDarkMode ? Colors.grey.shade900 : Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode
                          ? Colors.grey.shade900
                          : Colors.grey.shade300,
                      blurRadius: 6,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
              ),
            ),
            state.artboard == null
                ? const SizedBox.shrink()
                : Rive(
                    artboard: state.artboard!,
                    fit: BoxFit.fitWidth,
                  ),
            Positioned(
              top: 30,
              left: 30,
              child: Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 300),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode ? Colors.grey.shade800 : Colors.black26,
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Stack(children: [
                  Text(
                    "To give you the best experience, I’ll need to know a little about you first!",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                ]),
              ),
            ),
            Positioned(
              bottom: 60,
              child: ElevatedButton(
                onPressed: state.onContinueClick,
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
