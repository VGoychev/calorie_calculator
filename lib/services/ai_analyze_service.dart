import 'dart:convert';
import 'dart:developer' as developer;

import 'package:calorie_calculator/models/meal_item.dart';
import 'package:http/http.dart' as http;

class AiAnalyzeService {
  Future<List<MealItem>?> analyzeText(String text) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/meals/parse'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      final data = jsonDecode(response.body);
      return createMealFromAI(userInput: text, aiResponse: data);
    } catch (e) {
      developer.log('$e');
      return null;
    }
  }
}
