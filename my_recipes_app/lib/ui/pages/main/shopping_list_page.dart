import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/shopping_list.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/shopping_list_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/shopping_list_viewmodel.dart';
import 'package:provider/provider.dart';

class ShoppingListPage extends StatefulWidget {
  ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final TextEditingController shoppingListNameController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final shoppingListViewmodel = context.watch<ShoppingListViewmodel>();
    final userViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
        heroTag: 'addShoppingList',
        onPressed: () {
          showDialog(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: const Text('Create Shopping List'),
                  content: CustomTextField(
                    isPassword: false,
                    controller: shoppingListNameController,
                    labelText: 'Shopping List Name',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final name = Validations.firstLetterUpperCase(
                            shoppingListNameController.text);
                        await shoppingListViewmodel.addShoppingList(
                            ShoppingList(
                                name: name,
                                userId: userViewModel.currentUser!.id,
                                createdAt: null,
                                id: null));
                        shoppingListViewmodel.fetchShoppingListByUserId(
                            userViewModel.currentUser!.id!);
                        Navigator.of(dialogContext).pop();
                      },
                      child: const Text('Create'),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              shoppingListViewmodel
                  .fetchShoppingListByUserId(userViewModel.currentUser!.id!);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
              child: !isLoading
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        ShoppingListWidget(),
                        SizedBox(height: 20),
                        if (shoppingListViewmodel.shoppingLists.isNotEmpty)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomElevatedButtomWidget(
                              text: 'Clean up shopping lists',
                              width: 10,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                final shoppingListViewmodel =
                                    context.read<ShoppingListViewmodel>();
                                await shoppingListViewmodel.clearLists();
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                      ],
                    )
                  : Stack(
                      children: [
                        BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5)),
                        CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      ],
                    )),
        ),
      ),
    );
  }
}
