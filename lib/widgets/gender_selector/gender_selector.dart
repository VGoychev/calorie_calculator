import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final Function(String) onGenderSelected;
  final String? initialGender;

  const GenderSelector({
    super.key,
    required this.onGenderSelected,
    this.initialGender = 'Male',
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
  }

  @override
  void didUpdateWidget(GenderSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialGender != oldWidget.initialGender) {
      _selectedGender = widget.initialGender;
    }
  }

  void _handleGenderSelect(String gender) {
    setState(() {
      _selectedGender = gender;
    });
    widget.onGenderSelected(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildGenderButton('Male'),
        _buildGenderButton('Female'),
        _buildGenderButton('Other'),
      ],
    );
  }

  Widget _buildGenderButton(String gender) {
    final isSelected = _selectedGender == gender;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _handleGenderSelect(gender),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withOpacity(0.5),
            width: 2,
          ),
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
