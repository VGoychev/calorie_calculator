import 'dart:developer' as developer;

import 'package:calorie_calculator/models/user.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:calorie_calculator/widgets/profile_menu/profile_menu.dart';
import 'package:calorie_calculator/widgets/progress_card/progress_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  final void Function(String page) onPageChanged;

  const HomeTab({super.key, required this.onPageChanged});

  @override
  State<StatefulWidget> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  User? _user;
  @override
  void initState() {
    super.initState();
    assignUser();
  }

  Future<User?> getCurrentUser() async {
    try {
      final uid = await authService.getCurrentUserId();
      final user = await firestoreService.getUserById(uid);
      return user;
    } catch (e) {
      developer.log('$e');
      return null;
    }
  }

  void assignUser() async {
    _user = await getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 120, child: Stack(children: [ProfileMenu()])),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    primaryColor,
                    AppTheme.lighterGreen,
                  ]),
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black : Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -80,
                left: 0,
                width: 180,
                child: Image.asset(
                  'assets/images/sammy_jumping.png',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 56,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProgressCard(onTap: () => widget.onPageChanged('meals')),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isDark
                            ? const [
                                Color(0xFF1a1a1a),
                                Color(0xFF121212),
                              ]
                            : const [
                                Color(0xFFfafafa),
                                Color(0xFFf5f5f5),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(120),
                          blurRadius: 6,
                          offset: const Offset(4, 4),
                        ),
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withAlpha(20),
                          blurRadius: 15,
                          offset: const Offset(0, -3),
                          spreadRadius: -5,
                        ),
                      ],
                      border: Border.all(
                        color: isDark ? primaryColor : AppTheme.lighterGreen,
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// 🔥 CHART (width + height guaranteed)
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
                                      getDrawingHorizontalLine: (value) =>
                                          FlLine(
                                        color: isDark
                                            ? Colors.white10
                                            : Colors.black12,
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
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                value.toInt() >= 0 &&
                                                        value.toInt() <
                                                            days.length
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
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border(
                                        left: BorderSide(
                                          color: isDark
                                              ? Colors.white24
                                              : Colors.black26,
                                        ),
                                        bottom: BorderSide(
                                          color: isDark
                                              ? Colors.white24
                                              : Colors.black26,
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
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
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
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
