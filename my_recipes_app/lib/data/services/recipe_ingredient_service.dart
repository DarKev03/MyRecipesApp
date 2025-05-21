import 'dart:convert';

import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:http/http.dart' as http;

class RecipeIngredientService {
  final baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<List<RecipeIngredient>> getIngredientsByRecipeId(int recipeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recipe-ingredients/$recipeId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map(
              (recipeIngredient) => RecipeIngredient.fromJson(recipeIngredient))
          .toList();
    } else {
      throw Exception('Error fetching recipe ingredients');
    }
  }

  Future<RecipeIngredient> createRecipeIngredient(
      RecipeIngredient recipeIngredient) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipe-ingredients'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipeIngredient.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return RecipeIngredient.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error creating recipe ingredient');
    }
  }

  Future<void> deleteRecipeIngredient(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/recipe-ingredients/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 204 || response.statusCode != 200) {
      throw Exception('Error deleting recipe ingredient');
    }
  }
}
