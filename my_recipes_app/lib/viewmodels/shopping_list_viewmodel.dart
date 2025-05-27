import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/shopping_list.dart';
import 'package:my_recipes_app/data/models/shopping_list_item.dart';
import 'package:my_recipes_app/data/repositories/shopping_list_repository.dart';

class ShoppingListViewmodel extends ChangeNotifier {
  final ShoppingListRepository _shoppingListRepository;

  List<ShoppingList> _shoppingLists = [];
  List<ShoppingListItem> _items = [];

  List<ShoppingListItem> get items => _items;
  List<ShoppingList> get shoppingLists => _shoppingLists;

  ShoppingListViewmodel({required ShoppingListRepository repository})
      : _shoppingListRepository = repository;

  //Funciones de items
  Future<void> addItemToShoppingList(ShoppingListItem shoppingListItem) async {
    try {
      await _shoppingListRepository.addItemToShoppingList(shoppingListItem);
      _items.add(shoppingListItem);
      notifyListeners();
    } catch (e) {
      print('Error adding item to shopping list: $e');
    }
  }

  void deleteItemsFromShoppingListDeleted(ShoppingList shoppingList) {
    _items.removeWhere((item) => item.shoppingListId == shoppingList.id);
    notifyListeners();
  }

  Future<void> removeItem(int itemId) async {
    try {
      await _shoppingListRepository.removeItemFromShoppingList(itemId);
      _items.removeWhere((item) => item.id == itemId);
      notifyListeners();
    } catch (e) {
      print('Error removing item from shopping list: $e');
    }
  }

  //Funciones de shopping list
  Future<void> fetchShoppingListByUserId(int userId) async {
    try {
      _shoppingLists =
          await _shoppingListRepository.getShoppingListByUserId(userId);
      _items = shoppingLists
          .where((list) => list.items != null)
          .expand((list) => list.items!)
          .toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching shopping list: $e');
    }
  }

  Future<void> addShoppingList(ShoppingList shoppingList) async {
    try {
      await _shoppingListRepository.createShoppingList(shoppingList);
      _shoppingLists.add(shoppingList);
      notifyListeners();
    } catch (e) {
      print('Error adding shopping list: $e');
    }
  }

  Future<void> removeShoppingList(ShoppingList shoppingList) async {
    try {
      deleteItemsFromShoppingListDeleted(shoppingList);
      _shoppingLists.remove(shoppingList);
      notifyListeners();
      await _shoppingListRepository.deleteShoppingList(shoppingList.id!);
    } catch (e) {
      print('Error removing shopping list: $e');
    }
  }

  Future<void> clearLists() async {
    try {
      for (var item in _items) {
        await _shoppingListRepository.removeItemFromShoppingList(item.id!);
      }
      _items.clear();
      notifyListeners();
      for (var shoppingList in _shoppingLists) {
        await _shoppingListRepository.deleteShoppingList(shoppingList.id!);
      }
      _shoppingLists.clear();
      notifyListeners();
    } catch (e) {
      print('Error clearing shopping lists: $e');
    }
  }
}
