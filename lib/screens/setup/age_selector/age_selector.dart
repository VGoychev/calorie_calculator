import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class AgeSelector extends StatelessWidget {
  final Function(int) onSelected;
  final int initialIndex;

  const AgeSelector(
      {super.key, required this.onSelected, this.initialIndex = 18});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 32.0, height: 1.5);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 200,
          width: 150,
          child: WheelPicker(
            builder: (context, index) => Text("$index", style: textStyle),
            itemCount: 113,
            initialIndex: initialIndex,
            looping: false,
            selectedIndexColor: Theme.of(context).colorScheme.onSecondary,
            onIndexChanged: (index, interactionType) => onSelected(index),
            style: WheelPickerStyle(
              itemExtent: textStyle.fontSize! * textStyle.height!,
              squeeze: 1.25,
              diameterRatio: .8,
              surroundingOpacity: .25,
              magnification: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
