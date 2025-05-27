import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_recipes_app/data/models/shopping_list.dart';
import 'package:my_recipes_app/data/models/shopping_list_item.dart';

class ShoppingListService {
  final String baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<ShoppingListItem> addItemToShoppingList(
      ShoppingListItem shoppingListItem) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.121:8080/api/shopping-list-items'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        shoppingListItem.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      return ShoppingListItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add item to shopping list');
    }
  }

  Future<void> removeItemFromShoppingList(int itemId) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.121:8080/api/shopping-list-items/$itemId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to remove item from shopping list');
    }
  }

  Future<List<ShoppingList>> getShoppingList() async {
    final response = await http.get(
      Uri.parse('$baseUrl/shopping-lists'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => ShoppingList.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch shopping list');
    }
  }

  Future<List<ShoppingList>> getShoppingListByUserId(int userId) async {
    final response = await http.get(
      Uri.parse('http://192.168.1.121:8080/api/shopping-lists/user/$userId'),

      ///shopping-lists/user/
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => ShoppingList.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch shopping list for user');
    }
  }

  Future<ShoppingList> createShoppingList(ShoppingList shoppingList) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.121:8080/api/shopping-lists'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        shoppingList.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      return ShoppingList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create shopping list');
    }
  }

  Future<void> updateShoppingList(ShoppingList shoppingList) async {
    final response = await http.put(
      Uri.parse('$baseUrl/shopping-lists/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        shoppingList.toJson(),
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update shopping list');
    }
  }

  Future<void> deleteShoppingList(int id) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.121:8080/api/shopping-lists/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete shopping list');
    }
  }
}
