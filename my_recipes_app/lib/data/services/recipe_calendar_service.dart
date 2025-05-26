import 'package:my_recipes_app/data/models/recipe_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeCalendarService {
  final String baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<List<RecipeCalendar>> getRecipeCalendarsByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/calendar/user/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((recipeCalendar) => RecipeCalendar.fromJson(recipeCalendar))
          .toList();
    } else {
      throw Exception('Error fetching recipe calendars');
    }
  }

  Future<RecipeCalendar> createRecipeCalendar(
      RecipeCalendar recipeCalendar) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/calendar'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(recipeCalendar.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return RecipeCalendar.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error creating recipe calendar');
    }
  }

  Future<void> deleteRecipeCalendar(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/calendar/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 204 || response.statusCode != 200) {
      throw Exception('Error deleting recipe calendar');
    }
  }
}
