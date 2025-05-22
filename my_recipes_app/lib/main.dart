import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/repositories/ingredient_repository.dart';
import 'package:my_recipes_app/data/repositories/instruction_repository.dart';
import 'package:my_recipes_app/data/repositories/recipe_ingredient_repository.dart';
import 'package:my_recipes_app/data/repositories/recipe_repository.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:my_recipes_app/app.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeViewModel(recipeRepository: RecipeRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(userRepository: UserRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => InstructionViewmodel(
              instructionRepository: InstructionRepository()),
        ),
        ChangeNotifierProvider(
            create: (_) => IngredientViewmodel(
                recipeIngredientRepository: RecipeIngredientRepository(),
                ingredientRepository: IngredientRepository()))
      ],
      child: const MainApp(),
    ),
  );
}
