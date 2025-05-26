import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/services/recipe_service.dart';

class RecipeRepository {
  final String baseUrl = 'https://myrecipesapi.onrender.com/api';

  Future<Recipe> createRecipe(Recipe recipe){
    return RecipeService().createRecipe(recipe);
  }

  Future<Recipe> updateRecipe(Recipe recipe) async {
    return await RecipeService().updateRecipe(recipe);
  }

  Future<void> deleteRecipe(int recipeId) async {
    return await RecipeService().deleteRecipe(recipeId);
  }

  Future<List<Recipe>> getAllRecipes() async {
    return await RecipeService().getAllRecipes();
  }

  Future<Recipe> getRecipeById(String recipeId) async {
    return await RecipeService().getRecipeById(recipeId);
  }

  Future<List<Recipe>> getRecipeByUserId(int userId) async {
    return await RecipeService().getRecipesByUserId(userId);
  }
}
