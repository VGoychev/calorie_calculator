import 'package:calorie_calculator/models/parsed_food.dart';

class TextHelper {
  static List<String> splitFoodParts(String input) {
    return input
        .toLowerCase()
        .split(RegExp(r'\b(and|with)\b|,|\+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  static List<ParsedFood> parseTextLocally(String input) {
    final parts = splitFoodParts(input);
    final List<ParsedFood> foods = [];

    final qtyFirst = RegExp(r'(\d+)\s?(g|ml)\s?([a-z\s]+)');
    final qtyLast = RegExp(r'([a-z\s]+)\s?(\d+)\s?(g|ml)');

    for (final part in parts) {
      final text = part.trim();

      RegExpMatch? match;

      match = qtyFirst.firstMatch(text);
      if (match != null) {
        foods.add(
          ParsedFood(
            quantity: int.parse(match.group(1)!),
            unit: match.group(2)!,
            name: match.group(3)!.trim(),
          ),
        );
        continue;
      }

      match = qtyLast.firstMatch(text);
      if (match != null) {
        foods.add(
          ParsedFood(
            quantity: int.parse(match.group(2)!),
            unit: match.group(3)!,
            name: match.group(1)!.trim(),
          ),
        );
        continue;
      }

      //no quantity → assume 1 piece
      foods.add(
        ParsedFood(
          name: text,
          quantity: 1,
          unit: 'piece',
        ),
      );
    }

    return foods;
  }

  static String normalizeFoodName(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static String singularize(String word) {
    if (word.endsWith('ies')) {
      return '${word.substring(0, word.length - 3)}y';
    }
    if (word.endsWith('s')) {
      return word.substring(0, word.length - 1);
    }
    return word;
  }
}
