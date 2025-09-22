import 'package:calorie_calculator/screens/setup/activity_level_selector/activity_level_selector.dart';
import 'package:calorie_calculator/screens/setup/age_selector/age_selector.dart';
import 'package:calorie_calculator/screens/setup/height_selector/height_selector.dart';
import 'package:calorie_calculator/screens/setup/setup.dart';
import 'package:calorie_calculator/screens/setup/weight_selector/weight_selector.dart';
import 'package:flutter/material.dart';

class SetupView extends StatelessWidget {
  final SetupState state;

  const SetupView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: state.pageController,
        children: [
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Select your height',
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    HeightSelector(
                        onSelected: (height) => state.height = height)
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Select your weight',
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    WeightSelector(
                        onSelectedWeight: (weight) => state.weightInt = weight,
                        onSelectedFraction: (fraction) =>
                            state.weightFraction = fraction)
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Select your age',
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AgeSelector(onSelected: (age) => state.age = age)
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Center(
                    child: Text(
                      'Select your activity level',
                      style: TextStyle(
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ActivityLevelSelector(
                      onSelected: (level) => state.activityLevel = level),
                ]),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
