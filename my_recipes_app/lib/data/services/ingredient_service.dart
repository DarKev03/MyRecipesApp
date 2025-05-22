import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_recipes_app/data/models/ingredient.dart';

class IngredientService {
  final String baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<List<Ingredient>> getAllIngredients() async {
    final response = await http.get(Uri.parse('$baseUrl/ingredients'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((ingredient) => Ingredient.fromJson(ingredient))
          .toList();
    } else {
      throw Exception('Failed to load ingredients');
    }
  }

  Future<Ingredient> createIngredient(Ingredient ingredient) async {
    final response = await http.post(Uri.parse('$baseUrl/ingredients'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(ingredient.toJson()));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Ingredient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create ingredient');
    }
  }

  Future<void> deleteIngredient(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/ingredients/$id'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 204 || response.statusCode != 200) {
      throw Exception('Failed to delete ingredient');
    }
  }

  Future<Ingredient> getIngredientById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/ingredients/$id'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return Ingredient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load ingredient');
    }
  }
}
