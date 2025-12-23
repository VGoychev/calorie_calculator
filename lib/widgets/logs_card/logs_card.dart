import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LogsCard extends StatelessWidget {
  final VoidCallback? onTap;

  const LogsCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Container(
        width: double.infinity,
        decoration: AppTheme.homeContainerDecoration(context),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) => FlLine(
                                color: isDark ? Colors.white10 : Colors.black12,
                                strokeWidth: 1,
                              ),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 32,
                                  interval: 2,
                                  getTitlesWidget: (value, _) => Text(
                                    value.toInt().toString(),
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white54
                                          : Colors.black54,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  reservedSize: 22,
                                  getTitlesWidget: (value, _) {
                                    const days = [
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat',
                                      'Sun'
                                    ];
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        value.toInt() >= 0 &&
                                                value.toInt() < days.length
                                            ? days[value.toInt()]
                                            : '',
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black87,
                                          fontSize: 10,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                left: BorderSide(
                                  color:
                                      isDark ? Colors.white24 : Colors.black26,
                                ),
                                bottom: BorderSide(
                                  color:
                                      isDark ? Colors.white24 : Colors.black26,
                                ),
                              ),
                            ),
                            minX: 0,
                            maxX: 6,
                            minY: 68,
                            maxY: 76,
                            lineBarsData: [
                              LineChartBarData(
                                spots: const [
                                  FlSpot(0, 75),
                                  FlSpot(1, 74),
                                  FlSpot(2, 73.5),
                                  FlSpot(3, 73),
                                  FlSpot(4, 71.5),
                                  FlSpot(5, 70),
                                  FlSpot(6, 69),
                                ],
                                isCurved: true,
                                barWidth: 3,
                                color: Theme.of(context).primaryColor,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// 📊 TEXT INFO
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Body Weight",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Past Week (kg)",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          "Last: 69.0 kg",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Start: 75.0 kg",
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white12
                          : AppTheme.lighterGreen.withAlpha(45),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_calendar,
                          color: primaryColor,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "View Logs",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Check progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: primaryColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
