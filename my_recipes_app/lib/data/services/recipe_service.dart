import 'dart:convert';

import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeService {
  final String baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<Recipe> createRecipe(Recipe recipe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipe.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error creating recipe');
    }
  }

  Future<Recipe> updateRecipe(Recipe recipe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipe.toJson()),
    );

    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error updating recipe');
    }
  }

  Future<void> deleteRecipe(int recipeId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/recipes/$recipeId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error deleting recipe');
    }
  }

  Future<List<Recipe>> getAllRecipes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/recipes'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Error fetching recipes');
    }
  }

  Future<Recipe> getRecipeById(String recipeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recipes/$recipeId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error fetching recipe');
    }
  }

  Future<List<Recipe>> getRecipesByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/recipes/user/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);      
      return jsonResponse.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Error fetching recipes by user');
    }
  }
}