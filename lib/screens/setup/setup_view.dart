import 'package:calorie_calculator/screens/setup/activity_level_selector/activity_level_selector.dart';
import 'package:calorie_calculator/screens/setup/age_selector/age_selector.dart';
import 'package:calorie_calculator/screens/setup/gender_selector/gender_selector.dart';
import 'package:calorie_calculator/screens/setup/height_selector/height_selector.dart';
import 'package:calorie_calculator/screens/setup/setup.dart';
import 'package:calorie_calculator/screens/setup/weight_selector/weight_selector.dart';
import 'package:calorie_calculator/widgets/back_only_pageview.dart';
import 'package:flutter/material.dart';

class SetupView extends StatelessWidget {
  final SetupState state;

  const SetupView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackOnlyPageView(
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
                        'Select your gender',
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GenderSelector(
                      onGenderSelected: (gender) {
                        state.setGender(gender);
                      },
                      initialGender: state.gender,
                    )
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      state.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    child: Text(
                      'Next',
                      style: Theme.of(context).textTheme.bodyLarge,
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
                      onSelected: (height) {
                        state.setHeight(height);
                      },
                      initialIndex: state.height,
                    )
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      state.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
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
                      onSelectedWeight: (weight) {
                        state.setWeight(weight);
                      },
                      onSelectedFraction: (fraction) {
                        state.setWeightFraction(fraction);
                      },
                      initialIndex: state.weightInt,
                      initialFraction: state.weightFraction,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      state.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
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
                    AgeSelector(
                      onSelected: (age) {
                        state.setAge(age);
                      },
                      initialIndex: state.age,
                    )
                  ],
                ),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      state.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
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
                    onSelected: (level) {
                      state.setActivityLevel(level);
                    },
                    initialLevel: state.activityLevel,
                  ),
                ]),
                Positioned(
                  bottom: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      state.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
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
