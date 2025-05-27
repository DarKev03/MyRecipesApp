import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/shopping_list_widget.dart';
import 'package:my_recipes_app/viewmodels/shopping_list_viewmodel.dart';
import 'package:provider/provider.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingListViewmodel = context.watch<ShoppingListViewmodel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                ShoppingListWidget(),
                SizedBox(height: 20),
                if (shoppingListViewmodel.shoppingLists.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomElevatedButtomWidget(
                      text: 'Clean up shopping lists',
                      onPressed: () {
                        final shoppingListViewmodel =
                            context.read<ShoppingListViewmodel>();
                        shoppingListViewmodel.clearLists();
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
