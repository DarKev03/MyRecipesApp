import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/repositories/recipe_repository.dart';
import 'package:my_recipes_app/data/repositories/user_repository.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:my_recipes_app/app.dart';
import 'package:my_recipes_app/viewmodels/home_page_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              HomePageViewModel(recipeRepository: RecipeRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(userRepository: UserRepository()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
