import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/ingredient.dart';
import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:provider/provider.dart';

class IngredientsDynamicList extends StatefulWidget {
  final int? recipeId;
  const IngredientsDynamicList({super.key, this.recipeId});

  @override
  State<IngredientsDynamicList> createState() => _IngredientsDynamicListState();
}

class _IngredientsDynamicListState extends State<IngredientsDynamicList> {
  List<TextEditingController> ingredientNameControllers = [];
  List<TextEditingController> ingredientQuantityControllers = [];
  List<TextEditingController> ingredientUnitsControllers = [];

  @override
  void initState() {
    super.initState();
    _addIngredient();
  }

  @override
  void didUpdateWidget(covariant IngredientsDynamicList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.recipeId != widget.recipeId) {
      _saveIngredients();
    }
  }

  void _addIngredient() {
    setState(() {
      ingredientNameControllers.add(TextEditingController());
      ingredientQuantityControllers.add(TextEditingController());
      ingredientUnitsControllers.add(TextEditingController());
    });
  }

  void _removeIngredient() {
    for (var element in ingredientNameControllers) {
      element.dispose();
    }
    for (var element in ingredientQuantityControllers) {
      element.dispose();
    }
    for (var element in ingredientUnitsControllers) {
      element.dispose();
    }

    ingredientNameControllers = [];
    ingredientQuantityControllers = [];
    ingredientUnitsControllers = [];
  }

  void _saveIngredients() async {
    if (widget.recipeId == null) {
      return;
    } else {
      List<Ingredient> ingredients = [];
      List<Ingredient> ingredientsSaved = [];
      final recipesIngredientsViewmodel = context.read<IngredientViewmodel>();
      for (int i = 0; i < ingredientNameControllers.length; i++) {
        if (ingredientNameControllers[i].text.isEmpty) {
          return;
        }
        var name =
            Validations.firstLetterUpperCase(ingredientNameControllers[i].text);
        ingredients.add(Ingredient(
          id: null,
          name: name,
          description: null,
          createdAt: null,
        ));
      }
      for (var ingredient in ingredients) {
        ingredientsSaved
            .add(await recipesIngredientsViewmodel.addIngredient(ingredient));
      }

      List<RecipeIngredient> recipeIngredients = [];

      for (int i = 0; i < ingredients.length; i++) {
        recipeIngredients.add(RecipeIngredient(
          id: null,
          recipeId: widget.recipeId!,
          ingredientName: ingredientsSaved[i].name,
          ingredientId: ingredientsSaved[i].id!,
          quantity: double.tryParse(ingredientQuantityControllers[i].text),
          unit: ingredientUnitsControllers[i].text,
        ));
      }
      for (var recipeIngredient in recipeIngredients) {
        await recipesIngredientsViewmodel.addRecipeIngredient(recipeIngredient);
      }

      _removeIngredient();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ingredientNameControllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    ingredientNameControllers.removeAt(index);
                    ingredientQuantityControllers.removeAt(index);
                    ingredientUnitsControllers.removeAt(index);
                  });
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomTextField(
                        controller: ingredientNameControllers[index],
                        isPassword: false,
                        labelText: 'Ingredient',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        controller: ingredientQuantityControllers[index],
                        keyboardType: TextInputType.number,
                        isPassword: false,
                        labelText: 'Quantity',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        controller: ingredientUnitsControllers[index],
                        isPassword: false,
                        labelText: 'Unit',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        CustomElevatedButtomWidget(
          height: 10,
          width: 100,
          text: 'Añadir ingrediente',
          onPressed: () {
            _addIngredient();
          },
        ),
      ],
    );
  }
}
