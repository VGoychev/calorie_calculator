import 'dart:developer' as developer;

import 'package:calorie_calculator/models/user.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/theme/app_theme.dart';
import 'package:calorie_calculator/widgets/logs_card/logs_card.dart';
import 'package:calorie_calculator/widgets/profile_menu/profile_menu.dart';
import 'package:calorie_calculator/widgets/progress_card/progress_card.dart';
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
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 220, child: Stack(children: [ProfileMenu()])),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 64,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0, top: 8),
                        child: Text(
                          "Daily Nutrition Overview",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                      ProgressCard(onTap: () => widget.onPageChanged('meals')),
                      SizedBox(
                        height: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text(
                          "Weekly Progress & Trends",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                      LogsCard(
                        onTap: () => widget.onPageChanged('logs'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: 200,
          left: 0,
          right: 0,
          child: Container(
            height: 64,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  bottom: BorderSide(
                      color: isDark ? Colors.white24 : Colors.black12,
                      width: 0.5),
                  right: BorderSide(
                      color: isDark ? Colors.white24 : Colors.black12,
                      width: 0.5),
                  left: BorderSide(
                      color: isDark ? Colors.white24 : Colors.black12,
                      width: 0.5),
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 8),
                      blurRadius: 12,
                      spreadRadius: 0)
                ]),
          ),
        ),
        Positioned(
          top: 130,
          left: 10,
          child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width - 20,
              decoration: AppTheme.homeContainerDecoration(context)),
        ),
        Positioned(
          top: 40,
          left: 0,
          width: 180,
          child: Image.asset(
            'assets/images/sammy_jumping.png',
          ),
        ),
      ],
    );
  }
}
