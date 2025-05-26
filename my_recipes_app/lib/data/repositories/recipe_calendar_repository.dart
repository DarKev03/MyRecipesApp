import 'package:my_recipes_app/data/models/recipe_calendar.dart';
import 'package:my_recipes_app/data/services/recipe_calendar_service.dart';

class RecipeCalendarRepository {
  RecipeCalendarService recipeCalendarService = RecipeCalendarService();

  Future<List<RecipeCalendar>> getRecipeCalendarsByUserId(int userId) {
    return recipeCalendarService.getRecipeCalendarsByUserId(userId);
  }

  Future<RecipeCalendar> createRecipeCalendar(RecipeCalendar recipeCalendar) {
    return recipeCalendarService.createRecipeCalendar(recipeCalendar);
  }

  Future<void> deleteRecipeCalendar(int id) {
    return recipeCalendarService.deleteRecipeCalendar(id);
  }
}