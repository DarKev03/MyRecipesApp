import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class NextRecipesWidget extends StatelessWidget {
  const NextRecipesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeViewModel>(builder: (context, viewModel, child) {
      final recipesCalendar = viewModel.allRecipeCalendars;
      if (recipesCalendar.isNotEmpty) {
        return ListView.builder(
          itemCount: recipesCalendar.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final recipe = recipesCalendar[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.secondaryColor,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              title: Text(recipe.recipeTitle ?? '',
                  style: TextStyle(
                    fontSize: 14,
                  )),
              subtitle: Text(recipe.notes ?? '',
                  style: TextStyle(
                    fontSize: 12,
              )),
              trailing: Text(
                '${recipe.scheduledDate?.day}/${recipe.scheduledDate?.month}/${recipe.scheduledDate?.year}',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            );
          },
        );
      } else {
        return Center(
          child: Text(
            'No recipes available',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        );
      }
    });
  }
}
