import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_recipes_app/data/models/instruction.dart';

class InstructionService {
  final String baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<List<Instruction>> getInstructionsByRecipeId(int recipeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/instructions/recipe/$recipeId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((instruction) => Instruction.fromJson(instruction))
          .toList();
    } else {
      throw Exception('Error fetching instructions');
    }
  }

  Future<Instruction> createInstruction(Instruction instruction) async {
    final response = await http.post(
      Uri.parse('$baseUrl/instructions'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(instruction.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Instruction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error creating instruction');
    }
  }

  Future<void> deleteInstruction(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/instructions/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error deleting instruction');
    }
  }

  Future<List<Instruction>> getInstructionsByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/instructions/user/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((instruction) => Instruction.fromJson(instruction))
          .toList();
    } else {
      throw Exception('Error fetching instructions');
    }
  }

  Future<Instruction> updateInstruction(Instruction instruction) async {
    final response = await http.put(
      Uri.parse('$baseUrl/instructions/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(instruction.toJson()),
    );

    if (response.statusCode == 200) {
      return Instruction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error updating instruction');
    }
  }
}
