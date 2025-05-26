import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/repositories/recipe_calendar_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ysccfnuyictzgvydbbaq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlzY2NmbnV5aWN0emd2eWRiYmFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0OTM3MDQsImV4cCI6MjA2MzA2OTcwNH0.rn6E0cbJm4rao2EXcyx1UcS4QQkSWEcKQr1BZquqaYQ',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RecipeViewModel(recipeRepository: RecipeRepository(), recipeCalendarRepository: RecipeCalendarRepository()),
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
              ingredientRepository: IngredientRepository()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
