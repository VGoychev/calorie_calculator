import 'dart:developer' as developer;

import 'package:calorie_calculator/models/user_meal_entry.dart';
import 'package:calorie_calculator/services/auth_service.dart';
import 'package:calorie_calculator/services/firestore_service.dart';
import 'package:calorie_calculator/widgets/meals/meal_section/meal_section.dart';
import 'package:calorie_calculator/widgets/progress_card/progress_card.dart';
import 'package:flutter/material.dart';

class MealsTab extends StatefulWidget {
  const MealsTab({super.key});

  @override
  State<MealsTab> createState() => MealsTabState();
}

class MealsTabState extends State<MealsTab> {
  List<UserMealEntry> breakfastMeals = [];
  List<UserMealEntry> lunchMeals = [];
  List<UserMealEntry> dinnerMeals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  @override
  void didUpdateWidget(MealsTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadMeals();
  }

  Future<void> _loadMeals() async {
    setState(() {
      isLoading = true;
    });

    try {
      final uid = await authService.getCurrentUserId();
      developer.log('Loading meals for uid: $uid');
      
      if (uid.isEmpty) {
        developer.log('UID is empty, returning empty meals');
        setState(() {
          breakfastMeals = [];
          lunchMeals = [];
          dinnerMeals = [];
          isLoading = false;
        });
        return;
      }

      final now = DateTime.now();
      final dateString = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      developer.log('Loading meals for date: $dateString');

      final allMeals = await firestoreService.getAllMealsForDate(
        uid: uid,
        date: now,
      );

      developer.log('Retrieved meals - Breakfast: ${allMeals['breakfast']?.length ?? 0}, Lunch: ${allMeals['lunch']?.length ?? 0}, Dinner: ${allMeals['dinner']?.length ?? 0}');

      if (mounted) {
        setState(() {
          breakfastMeals = allMeals['breakfast'] ?? [];
          lunchMeals = allMeals['lunch'] ?? [];
          dinnerMeals = allMeals['dinner'] ?? [];
          isLoading = false;
        });
        developer.log('Meals state updated');
      }
    } catch (e, stackTrace) {
      developer.log(
        'Error loading meals',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        setState(() {
          breakfastMeals = [];
          lunchMeals = [];
          dinnerMeals = [];
          isLoading = false;
        });
      }
    }
  }

  void refreshMeals() {
    _loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          ProgressCard(
            includeMealsNavigator: false,
          ),
          SizedBox(height: 12),
          Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 12),

                          MealSection(
                            title: 'Breakfast',
                            icon: Icons.wb_sunny_outlined,
                            meals: breakfastMeals,
                          ),

                          SizedBox(height: 16),

                          MealSection(
                            title: 'Lunch',
                            icon: Icons.lunch_dining_outlined,
                            meals: lunchMeals,
                          ),

                          SizedBox(height: 16),

                          MealSection(
                            title: 'Dinner',
                            icon: Icons.dinner_dining_outlined,
                            meals: dinnerMeals,
                          ),
                        ],
                      ),
                    )),
        ],
      ),
    );
  }
}
