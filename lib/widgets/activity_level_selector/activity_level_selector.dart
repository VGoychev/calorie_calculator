import 'package:flutter/material.dart';

class ActivityLevelSelector extends StatefulWidget {
  final Function(String) onSelected;
  final String initialLevel;
  const ActivityLevelSelector(
      {super.key, required this.onSelected, this.initialLevel = "Light"});

  @override
  State<ActivityLevelSelector> createState() => _ActivityLevelSelectorState();
}

class _ActivityLevelSelectorState extends State<ActivityLevelSelector> {
  late String selectedLevel;

  @override
  void initState() {
    super.initState();
    selectedLevel = widget.initialLevel;
  }

  @override
  void didUpdateWidget(ActivityLevelSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialLevel != oldWidget.initialLevel) {
      selectedLevel = widget.initialLevel;
    }
  }

  final activityLevels = [
    {
      "title": "Sedentary",
      "subtitle": "Little to no working out",
    },
    {
      "title": "Light",
      "subtitle": "Working out 1–3 days/week",
    },
    {
      "title": "Moderate",
      "subtitle": "Working out 3–5 days/week",
    },
    {
      "title": "Active",
      "subtitle": "Working out 6–7 days/week",
    },
    {
      "title": "Very Active",
      "subtitle": "Daily workouts & physical job",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: activityLevels.map((level) {
        final isSelected = level["title"] == selectedLevel;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                selectedLevel = level["title"]!;
              });
              widget.onSelected(level["title"]!);
            },
            child: Card(
              elevation: isSelected ? 4 : 1,
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  level["title"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(level["subtitle"]!),
                trailing: isSelected
                    ? Icon(Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary)
                    : null,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
