import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/repositories/recipe_repository.dart';

class HomePageViewModel extends ChangeNotifier {
  final RecipeRepository _recipeRepository;
  List<Recipe> _recipes = [];
  List<Recipe> _recentlyRecipes = [];

  List<Recipe> get recipes => _recipes;
  List<Recipe> get recentlyRecipes => _recentlyRecipes;
  List<Recipe> get favoriteRecipes =>
      _recipes.where((recipe) => recipe.isFavorite!).toList();

  HomePageViewModel({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  Future<void> fetchRecipesByUser(User user) async {
    try {
      _recipes = await _recipeRepository.getRecipeByUserId(user.id!);

      _recentlyRecipes = List.from(_recipes)
        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

      if (_recentlyRecipes.length > 5) {
        _recentlyRecipes = _recentlyRecipes.sublist(0, 5);
      } else {
        _recentlyRecipes = _recentlyRecipes.sublist(0, _recentlyRecipes.length);
      }

      notifyListeners();
    } catch (e) {
      print("Error fetching recipes: $e");
    }
  }
}
