import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/shopping_list_viewmodel.dart';
import 'package:provider/provider.dart';

class ShoppingListWidget extends StatelessWidget {
  const ShoppingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingListViewmodel>(
      builder: (BuildContext context, shoppingListViewmodel, Widget? child) {
        final shoppingLists = shoppingListViewmodel.shoppingLists;
        final items = shoppingListViewmodel.items;

        return shoppingLists.isNotEmpty
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: shoppingLists.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final shoppingList = shoppingLists[index];
                  return Dismissible(
                    key: Key(shoppingList.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(                      
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shoppingList.name!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...items
                                  .where((item) =>
                                      item.shoppingListId == shoppingList.id)
                                  .map((item) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 6,
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                          ),
                                          title: Text(item.ingredientName!),
                                          subtitle: item.quantity != null
                                              ? Text(
                                                  'Quantity: ${item.quantity}',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: AppColors
                                                        .secondaryColor,
                                                  ))
                                              : null,
                                          trailing: IconButton(
                                            icon: const Icon(Icons.delete,
                                                color:
                                                    AppColors.secondaryColor),
                                            onPressed: () {
                                              shoppingListViewmodel
                                                  .removeItem(item.id!);
                                            },
                                          ),
                                        ),
                                      )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Container(
                height: MediaQuery.of(context).size.height *
                    0.4,
                alignment: Alignment.center,
                child: Text(
                  'No shopping lists available',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.secondaryColor,
                  ),
                ),
              );
      },
    );
  }
}
