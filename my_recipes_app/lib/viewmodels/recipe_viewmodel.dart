import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/recipe_calendar.dart';
import 'package:my_recipes_app/data/models/user.dart';
import 'package:my_recipes_app/data/repositories/recipe_calendar_repository.dart';
import 'package:my_recipes_app/data/repositories/recipe_repository.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeRepository _recipeRepository;
  final RecipeCalendarRepository _recipeCalendarRepository;
  List<Recipe> _recipes = [];
  List<Recipe> _recentlyRecipes = [];
  List<Recipe> _filteredRecipes = [];
  final List<String> _selectedCategories = [];
  List<RecipeCalendar> _allRecipeCalendars = [];
  List<Recipe> _recipesPerDay = [];

  //getters
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

  List<RecipeCalendar> get allRecipeCalendars => _allRecipeCalendars;

  List<RecipeCalendar> get allRecipesOrdered => _allRecipeCalendars
    ..sort((a, b) => a.scheduledDate!.compareTo(b.scheduledDate!));

  List<Recipe> get recipesPerDay => _recipesPerDay;

  //Constructor y funcionas
  RecipeViewModel(
      {required RecipeRepository recipeRepository,
      required RecipeCalendarRepository recipeCalendarRepository})
      : _recipeRepository = recipeRepository,
        _recipeCalendarRepository = recipeCalendarRepository;

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
      _filteredRecipes = List.from(_recipes);
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
      final recipeUpdated = await _recipeRepository.updateRecipe(recipe);
      final index = _recipes.indexWhere((r) => r.id == recipe.id);
      if (index != -1) {
        _recipes[index] = recipeUpdated;
      } else {
        print("Recipe not found for update");
      }
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

  Future<void> fetchRecipeCalendarsByUserId(int userId) async {
    try {
      _allRecipeCalendars.clear();
      _allRecipeCalendars =
          await _recipeCalendarRepository.getRecipeCalendarsByUserId(userId);
      notifyListeners();
    } catch (e) {
      print("Error fetching recipe calendars: $e");
    }
  }

  Future<void> addRecipeCalendar(RecipeCalendar recipeCalendar) async {
    try {
      final newRecipeCalendar =
          await _recipeCalendarRepository.createRecipeCalendar(recipeCalendar);
      _allRecipeCalendars.add(newRecipeCalendar);
      notifyListeners();
    } catch (e) {
      print("Error adding recipe calendar: $e");
    }
  }

  void setRecipesPerDay(DateTime date) {
    final recipesForDay = _allRecipeCalendars.where((recipeCalendar) {
      final calendarDate = recipeCalendar.scheduledDate!;
      return calendarDate.year == date.year &&
          calendarDate.month == date.month &&
          calendarDate.day == date.day;
    }).toList();

    final recipeIds = recipesForDay.map((e) => e.recipeId).toSet();

    _recipesPerDay = _recipes.where((recipe) {
      return recipeIds.contains(recipe.id);
    }).toList();

    notifyListeners();
  }

  Future<void> deleteRecipe(int id) async {
    try {
      await _recipeRepository.deleteRecipe(id);
      _recipes.removeWhere((recipe) => recipe.id == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting recipe: $e");
    }
  }

  Future<void> deleteRecipeCalendar(int id) async {
    try {
      final recipe = _recipesPerDay.where((recipe) => recipe.id == id).first;
      final recipeCalendarToDelete = _allRecipeCalendars
          .where((calendar) => calendar.recipeId == recipe.id)
          .first;
      _allRecipeCalendars.remove(recipeCalendarToDelete);
      notifyListeners();
      await _recipeCalendarRepository.deleteRecipeCalendar(
        recipeCalendarToDelete.id!,
      );
    } catch (e) {
      print("Error deleting recipe calendar: $e");
    }
  }
}
