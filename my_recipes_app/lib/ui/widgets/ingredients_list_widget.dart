import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/shopping_list.dart';
import 'package:my_recipes_app/data/models/shopping_list_item.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/shopping_list_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                child: Text(AppLocalizations.of(context)!.noIngredientsFound),
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
                            final loginViewModel =
                                context.read<UserViewModel>();
                            return AlertDialog(
                              title: Text('Añadir a una lista de la compra'),
                              content: shoppingLists.isEmpty
                                  ? Text(
                                      'No hay listas disponibles.\n¿Quieres crear una?')
                                  : SizedBox(
                                      width: double.maxFinite,
                                      height: 300,
                                      child: ListView.builder(
                                        itemCount: shoppingLists.length,
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
                                      Navigator.of(dialogContext).pop();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          bool isLoading = false;
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return !isLoading
                                                  ? AlertDialog(
                                                      title: Text(
                                                          'Crear lista de compra'),
                                                      content: Text(
                                                          '¿Quieres crear una nueva lista de compra?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              Text('Cancelar'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            setState(() {
                                                              isLoading = true;
                                                            });
                                                            await shoppingList
                                                                .addShoppingList(
                                                              ShoppingList(
                                                                id: null,
                                                                name:
                                                                    'Lista para ${recipe.title}',
                                                                userId: loginViewModel
                                                                    .currentUser!
                                                                    .id!,
                                                                createdAt: null,
                                                              ),
                                                            );
                                                            await shoppingList
                                                                .fetchShoppingListByUserId(
                                                                    loginViewModel
                                                                        .currentUser!
                                                                        .id!);
                                                            await shoppingList
                                                                .addItemToShoppingList(
                                                              ShoppingListItem(
                                                                ingredientId:
                                                                    ingredient
                                                                        .ingredientId,
                                                                id: null,
                                                                ingredientName:
                                                                    ingredient
                                                                        .ingredientName,
                                                                quantity:
                                                                    ingredient
                                                                        .quantity,
                                                                unit: ingredient
                                                                    .unit,
                                                                shoppingListId:
                                                                    shoppingList
                                                                        .shoppingLists
                                                                        .last
                                                                        .id,
                                                              ),
                                                            );
                                                            setState(() {
                                                              isLoading = false;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Crear'),
                                                        ),
                                                      ],
                                                    )
                                                  : AlertDialog(
                                                      title: Text(
                                                          'Creando lista de compra...'),
                                                      content: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: AppColors
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    );
                                            },
                                          );
                                        },
                                      );
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
