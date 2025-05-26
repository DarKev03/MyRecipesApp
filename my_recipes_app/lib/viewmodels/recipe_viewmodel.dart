import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/repositories/recipe_repository.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeRepository _recipeRepository;
  List<Recipe> _recipes = [];
  List<Recipe> _recentlyRecipes = [];
  List<Recipe> _filteredRecipes = [];
  final List<String> _selectedCategories = [];
  double _maxPreparationTime = 0;

  List<Recipe> get recipes => _recipes;

  List<Recipe> get recentlyRecipes => _recentlyRecipes;

  List<Recipe> get favoriteRecipes =>
      _recipes.where((recipe) => recipe.isFavorite!).toList();

  List<Recipe> get filteredRecipes => _filteredRecipes;

  List<String> get categoryRecipes =>
      _recipes.map((recipe) => recipe.category!).toSet().toList();

  List<String> get selectedCategories => _selectedCategories;
  double get maxPreparationTime => _maxPreparationTime;

  RecipeViewModel({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  void filterRecipes(String query) {
    _filteredRecipes = _recipes
        .where((recipe) =>
            recipe.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void setMaxPrepTime(double time) {
    _maxPreparationTime = time;
    notifyListeners();
  }

  void setSelectedCategory(String categorie) {
    _selectedCategories.add(categorie);
    notifyListeners();
  }

  void removeSelectedCategory(String categorie) {
    _selectedCategories.remove(categorie);
    notifyListeners();
  }

  Future<void> fetchRecipesByUser(User user) async {
    try {
      _recipes = await _recipeRepository.getRecipeByUserId(user.id!);
      fillRecentlyRecipes();
      notifyListeners();
    } catch (e) {
      print("Error fetching recipes: $e");
    }
  }

  void fillRecentlyRecipes() {
    _recentlyRecipes = List.from(_recipes)
      ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    if (_recentlyRecipes.length > 5) {
      _recentlyRecipes = _recentlyRecipes.sublist(0, 5);
    } else {
      _recentlyRecipes = _recentlyRecipes.sublist(0, _recentlyRecipes.length);
    }

    notifyListeners();
  }

  void toggleFavorite(Recipe recipe) {
    recipe.isFavorite = !recipe.isFavorite!;
    _recipeRepository.updateRecipe(recipe);
    notifyListeners();
  }

  Future<void> updateRecipe(Recipe recipe) async {
    try {
      _recipeRepository.updateRecipe(recipe);
      notifyListeners();
    } catch (e) {
      print("Error updating recipe: $e");
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    try {
      final recipeSaved = await _recipeRepository.createRecipe(recipe);
      _recipes.add(recipeSaved);
      notifyListeners();
    } catch (e) {
      print("Error adding recipe: $e");
    }
  }

  void resetFilters() {
    _selectedCategories.clear();
    _maxPreparationTime = 0;
    notifyListeners();
  }
}
