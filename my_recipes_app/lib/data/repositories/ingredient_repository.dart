import 'package:my_recipes_app/data/models/ingredient.dart';
import 'package:my_recipes_app/data/services/ingredient_service.dart';

class IngredientRepository {
  IngredientService ingredientService = IngredientService();

  Future<Ingredient> getIngredientById(int id) async {
    return await ingredientService.getIngredientById(id);
  }

  Future<Ingredient> createIngredient(Ingredient ingredient) async {
    return await ingredientService.createIngredient(ingredient);
  }

  Future<void> deleteIngredient(int id) async {
    return await ingredientService.deleteIngredient(id);
  }
}
