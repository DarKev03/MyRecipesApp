import 'package:my_recipes_app/data/models/shopping_list.dart';
import 'package:my_recipes_app/data/models/shopping_list_item.dart';
import 'package:my_recipes_app/data/services/shopping_list_service.dart';

class ShoppingListRepository {
  ShoppingListService shoppingListService = ShoppingListService();

  Future<void> addItemToShoppingList(ShoppingListItem shoppingListItem) async {
    await shoppingListService.addItemToShoppingList(shoppingListItem);
  }

  Future<void> removeItemFromShoppingList(int itemName) async {
    await shoppingListService.removeItemFromShoppingList(itemName);
  }

  Future<List<ShoppingList>> getShoppingList() async {
    return await shoppingListService.getShoppingList();
  }

  Future<List<ShoppingList>> getShoppingListByUserId(int userId) async {
    return await shoppingListService.getShoppingListByUserId(userId);
  }

  Future<void> createShoppingList(ShoppingList shoppingList) async {
    await shoppingListService.createShoppingList(shoppingList);
  }

  Future<void> updateShoppingList(ShoppingList shoppingList) async {
    await shoppingListService.updateShoppingList(shoppingList);
  }

  Future<void> deleteShoppingList(int shoppingListId) async {
    await shoppingListService.deleteShoppingList(shoppingListId);
  }
}
