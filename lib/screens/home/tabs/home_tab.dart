import 'dart:developer' as developer;

import 'package:calorie_calculator/models/user.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/widgets/circle_progress_stack/circle_progress_stack.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 120,
              child: Stack(children: [
                Positioned(
                  top: 60,
                  right: 20,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30)),
                    child: Icon(
                      Icons.person_4_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(100)),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
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
            height: 50,
          ),
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleProgressStack(),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildNutrientRow(Color.fromARGB(255, 64, 17, 250),
                                'Calories', '1,200/1800 kcal'),
                            SizedBox(height: 8),
                            _buildNutrientRow(
                                Color.fromARGB(255, 179, 108, 165), 'Proteins', '80/120 g'),
                            SizedBox(height: 8),
                            _buildNutrientRow(
                                Color.fromARGB(255, 255, 136, 0), 'Carbohydrates', '150/210 g'),
                            SizedBox(height: 8),
                            _buildNutrientRow(Colors.green, 'Fats', '60/88 g'),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNutrientRow(Color color, String label, String value) {
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
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: color),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
