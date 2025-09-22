import 'package:flutter/material.dart';

class ActivityLevelSelector extends StatefulWidget {
  final Function(String) onSelected; // callback when user selects

  const ActivityLevelSelector({super.key, required this.onSelected});

  @override
  State<ActivityLevelSelector> createState() => _ActivityLevelSelectorState();
}

class _ActivityLevelSelectorState extends State<ActivityLevelSelector> {
  String selectedLevel = '';

  final activityLevels = [
    'Sedentary',
    'Light',
    'Moderate',
    'Active',
    'Very Active',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activityLevels.map((level) {
        final isSelected = level == selectedLevel;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isSelected ? Colors.blue : Colors.grey[300],
              foregroundColor: isSelected ? Colors.white : Colors.black,
              minimumSize: Size(double.infinity, 50),
            ),
            onPressed: () {
              setState(() {
                selectedLevel = level;
              });
              widget.onSelected(level); // notify parent
            },
            child: Text(level),
          ),
        );
      }).toList(),
    );
  }
}
