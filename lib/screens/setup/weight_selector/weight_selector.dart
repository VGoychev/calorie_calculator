import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class WeightSelector extends StatelessWidget {
  final Function(int) onSelectedWeight;
  final Function(int) onSelectedFraction;
  final int initialIndex;

  const WeightSelector(
      {super.key,
      required this.onSelectedWeight,
      required this.onSelectedFraction,
      this.initialIndex = 70});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 32.0, height: 1.5);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Integer part picker
        SizedBox(
          height: 200,
          width: 100,
          child: WheelPicker(
            builder: (context, index) => Text("${index}", style: textStyle),
            itemCount: 380,
            initialIndex: 75,
            looping: false,
            selectedIndexColor: Theme.of(context).colorScheme.onSecondary,
            onIndexChanged: (index, _) {
              onSelectedWeight(index);
            },
            style: WheelPickerStyle(
              itemExtent: textStyle.fontSize! * textStyle.height!,
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
                color: Theme.of(context).colorScheme.onSecondary)),
        // Fractional part picker
        SizedBox(
          height: 200,
          width: 100,
          child: WheelPicker(
            builder: (context, index) => Text("$index", style: textStyle),
            itemCount: 10,
            looping: false,
            selectedIndexColor: Theme.of(context).colorScheme.onSecondary,
            onIndexChanged: (index, _) {
              onSelectedFraction(index);
            },
            style: WheelPickerStyle(
              itemExtent: textStyle.fontSize! * textStyle.height!,
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
                color: Theme.of(context).colorScheme.onSecondary)),
      ],
    );
  }
}
