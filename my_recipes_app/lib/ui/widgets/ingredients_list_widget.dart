import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:provider/provider.dart';

class IngredientsListWidget extends StatelessWidget {
  const IngredientsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IngredientViewmodel>(
      builder: (context, viewModel, child) {
        final ingredients = viewModel.ingredients;
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
                      radius: 8,
                      backgroundColor: AppColors.secondaryColor,
                    ),
                    title: Text(ingredient.ingredientName!,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryColor)),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_bag_outlined),
                      color: AppColors.primaryColor,
                    ),
                  );
                },
              );
      },
    );
  }
}
