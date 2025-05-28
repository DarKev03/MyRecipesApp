import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/shopping_list_item.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/shopping_list_viewmodel.dart';
import 'package:provider/provider.dart';

class IngredientsListWidget extends StatelessWidget {
  final Recipe recipe;
  const IngredientsListWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientViewmodel>(
      builder: (context, viewModel, child) {
        final ingredients = viewModel.allUserIngredients
            .where((ingredient) => ingredient.recipeId == recipe.id)
            .toList();
        return ingredients.isEmpty
            ? Center(
                child: Text('No ingredients available'),
              )
            : ListView.builder(
                itemCount: ingredients.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var ingredient = ingredients[index];
                  return ListTile(
                    contentPadding: EdgeInsets.only(right: 8, left: 16),
                    leading: CircleAvatar(
                      radius: 4,
                      backgroundColor: AppColors.secondaryColor,
                    ),
                    title: Text(ingredient.ingredientName!,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondaryColor)),
                    trailing: IconButton(
                      onPressed: () {
                        final ShoppingListViewmodel shoppingList =
                            context.read<ShoppingListViewmodel>();
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            final shoppingLists = shoppingList.shoppingLists;
                            return AlertDialog(
                              title: Text('Añadir a una lista de la compra'),
                              content: shoppingLists.isEmpty
                                  ? Text(
                                      'No hay listas disponibles.\n¿Quieres crear una?')
                                  : SizedBox(
                                      width: double.maxFinite,
                                      height: 300,
                                      child: ListView.builder(
                                        itemCount: shoppingLists
                                            .length, // <-- ¡Esto es clave!
                                        itemBuilder: (context, index) {
                                          final shoppingListElement =
                                              shoppingLists[index];
                                          return ListTile(
                                            title:
                                                Text(shoppingListElement.name!),
                                            onTap: () {
                                              var itemToSend = ShoppingListItem(
                                                ingredientId:
                                                    ingredient.ingredientId,
                                                id: null,
                                                ingredientName:
                                                    ingredient.ingredientName,
                                                quantity: ingredient.quantity,
                                                unit: ingredient.unit,
                                                shoppingListId:
                                                    shoppingListElement.id,
                                              );
                                              shoppingList
                                                  .addItemToShoppingList(
                                                      itemToSend);
                                              shoppingList
                                                  .fetchItemsByShoppingListId(
                                                      shoppingListElement.id!);
                                              Navigator.of(dialogContext).pop();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                if (shoppingLists.isEmpty)
                                  TextButton(
                                    onPressed: () {
                                      // Aquí puedes abrir un dialogo para crear lista
                                    },
                                    child: Text('Crear lista'),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.shopping_bag_outlined),
                      color: AppColors.primaryColor,
                    ),
                    subtitle: Text(
                      ingredient.quantity != null && ingredient.unit != null
                          ? '${ingredient.quantity} ${ingredient.unit}'
                          : '',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor),
                    ),
                  );
                },
              );
      },
    );
  }
}
