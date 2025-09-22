import 'package:calorie_calculator/screens/setup/activity_level_selector/activity_level_selector.dart';
import 'package:calorie_calculator/screens/setup/setup.dart';
import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class SetupView extends StatelessWidget {
  final SetupState state;

  const SetupView(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 32.0, height: 1.5);

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 150,
                          child: WheelPicker(
                            builder: (context, index) =>
                                Text("$index", style: textStyle),
                            selectedIndexColor:
                                Theme.of(context).colorScheme.onSecondary,
                            onIndexChanged: (index, interactionType) =>
                                state.heightIndex = index,
                            itemCount: 273,
                            initialIndex: 170,
                            looping: false,
                            style: WheelPickerStyle(
                              itemExtent:
                                  textStyle.fontSize! * textStyle.height!,
                              squeeze: 1.25,
                              diameterRatio: .8,
                              surroundingOpacity: .25,
                              magnification: 1.2,
                            ),
                          ),
                        ),
                        Text(
                          'cm',
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onSecondary),
                        )
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Integer part picker
                        SizedBox(
                          height: 200,
                          width: 100,
                          child: WheelPicker(
                            builder: (context, index) =>
                                Text("${index}", style: textStyle),
                            itemCount: 380,
                            initialIndex: 75,
                            looping: false,
                            selectedIndexColor:
                                Theme.of(context).colorScheme.onSecondary,
                            onIndexChanged: (index, _) {
                              state.weightInt = index;
                            },
                            style: WheelPickerStyle(
                              itemExtent:
                                  textStyle.fontSize! * textStyle.height!,
                              squeeze: 1.25,
                              diameterRatio: .8,
                              surroundingOpacity: .25,
                              magnification: 1.2,
                            ),
                          ),
                        ),
                        Text(".",
                            style: TextStyle(
                                fontSize: 32,
                                color:
                                    Theme.of(context).colorScheme.onSecondary)),
                        // Fractional part picker
                        SizedBox(
                          height: 200,
                          width: 100,
                          child: WheelPicker(
                            builder: (context, index) =>
                                Text("$index", style: textStyle),
                            itemCount: 10,
                            looping: false,
                            selectedIndexColor:
                                Theme.of(context).colorScheme.onSecondary,
                            onIndexChanged: (index, _) {
                              state.weightFraction = index;
                            },
                            style: WheelPickerStyle(
                              itemExtent:
                                  textStyle.fontSize! * textStyle.height!,
                              squeeze: 1.25,
                              diameterRatio: .8,
                              surroundingOpacity: .25,
                              magnification: 1.2,
                            ),
                          ),
                        ),
                        Text("kg",
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onSecondary)),
                      ],
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 150,
                          child: WheelPicker(
                            builder: (context, index) =>
                                Text("$index", style: textStyle),
                            itemCount: 113,
                            initialIndex: 18,
                            looping: false,
                            selectedIndexColor:
                                Theme.of(context).colorScheme.onSecondary,
                            onIndexChanged: (index, interactionType) =>
                                state.heightIndex = index,
                            style: WheelPickerStyle(
                              itemExtent:
                                  textStyle.fontSize! * textStyle.height!,
                              squeeze: 1.25,
                              diameterRatio: .8,
                              surroundingOpacity: .25,
                              magnification: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  ActivityLevelSelector(onSelected: (level) {
                    state.activityLevel = level;
                  }),
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
