import 'dart:convert';

import 'package:my_recipes_app/data/models/user.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String _baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<User> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear usuario');
    }
  }

  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/users/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar usuario');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar usuario');
    }
  }

  Future<List<User>> getAllUsers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  Future<User> getUserById(String userId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener usuario');
    }
  }

  Future<User> loginUser(User user) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {      
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al iniciar sesión');
    }
  }
}
