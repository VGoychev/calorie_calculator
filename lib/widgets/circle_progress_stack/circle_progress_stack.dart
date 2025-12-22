import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircleProgressStack extends StatefulWidget {
  final double calorieProgress; // 0.0 to 1.0
  final double proteinProgress; // 0.0 to 1.0
  final double carbProgress; // 0.0 to 1.0
  final double fatProgress;

  const CircleProgressStack({
    super.key,
    this.calorieProgress = 0.65,
    this.proteinProgress = 0.45,
    this.carbProgress = 0.80,
    this.fatProgress = 0.25,
  });

  @override
  State<CircleProgressStack> createState() => _CircleProgressStackState();
}

class _CircleProgressStackState extends State<CircleProgressStack> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularPercentIndicator(
            radius: 70,
            lineWidth: 12,
            percent: widget.calorieProgress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppTheme.red,
            backgroundColor: AppTheme.red.withAlpha(50),
            animation: true,
            animationDuration: 1000,
            startAngle: 270,
          ),
          CircularPercentIndicator(
            radius: 55,
            lineWidth: 12,
            percent: widget.proteinProgress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppTheme.blue,
            backgroundColor: AppTheme.blue.withAlpha(50),
            animation: true,
            animationDuration: 1200,
            startAngle: 270,
          ),
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 12,
            percent: widget.carbProgress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.green,
            backgroundColor: Colors.green.withAlpha(50),
            animation: true,
            animationDuration: 1400,
            startAngle: 270,
          ),
          CircularPercentIndicator(
            radius: 25,
            lineWidth: 12,
            percent: widget.fatProgress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppTheme.purple,
            backgroundColor: AppTheme.purple.withAlpha(50),
            animation: true,
            animationDuration: 1400,
            startAngle: 270,
          ),
        ],
      ),
    );
  }
}
