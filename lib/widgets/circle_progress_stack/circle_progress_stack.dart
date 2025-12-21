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
            progressColor: Color.fromARGB(255, 64, 17, 250),
            backgroundColor: Color.fromARGB(255, 64, 17, 250).withAlpha(50),
            animation: true,
            animationDuration: 1000,
            startAngle: 270,
          ),
          CircularPercentIndicator(
            radius: 55,
            lineWidth: 12,
            percent: widget.proteinProgress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Color.fromARGB(255, 179, 108, 165),
            backgroundColor: Color.fromARGB(255, 179, 108, 165).withAlpha(50),
            animation: true,
            animationDuration: 1200,
            startAngle: 270,
          ),
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 12,
            percent: widget.carbProgress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Color.fromARGB(255, 255, 136, 0),
            backgroundColor: Color.fromARGB(255, 255, 136, 0).withAlpha(50),
            animation: true,
            animationDuration: 1400,
            startAngle: 270,
          ),
          CircularPercentIndicator(
            radius: 25,
            lineWidth: 12,
            percent: widget.fatProgress,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Color(0xFF00E0E4),
            backgroundColor: Color(0xFF00E0E4).withOpacity(0.2),
            animation: true,
            animationDuration: 1400,
            startAngle: 270,
          ),
        ],
      ),
    );
  }
}

// Example usage:
class FitnessRingsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleProgressStack(
              calorieProgress: 0.65,
              proteinProgress: 0.45,
              carbProgress: 0.80,
              fatProgress: 0.25,
            ),
            SizedBox(height: 30),
            // You can add labels here if needed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegend(Color(0xFFFA114F), 'Move'),
                SizedBox(width: 20),
                _buildLegend(Color(0xFF92E82A), 'Exercise'),
                SizedBox(width: 20),
                _buildLegend(Color(0xFF00E0E4), 'Stand'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
