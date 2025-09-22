import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';

class HeightSelector extends StatelessWidget {
  final Function(int) onSelected;
  final int initialIndex;

  const HeightSelector({
    super.key,
    required this.onSelected,
    this.initialIndex = 170,
  });

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
            selectedIndexColor: Theme.of(context).colorScheme.onSecondary,
            onIndexChanged: (index, interactionType) => onSelected(index),
            itemCount: 273,
            initialIndex: initialIndex,
            looping: false,
            style: WheelPickerStyle(
              itemExtent: textStyle.fontSize! * textStyle.height!,
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
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        )
      ],
    );
  }
}
