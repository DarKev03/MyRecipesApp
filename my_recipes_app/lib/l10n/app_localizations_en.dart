// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get upcomingPlannings => 'Upcoming plannings';

  @override
  String get name => 'Name';

  @override
  String get category => 'Category';

  @override
  String get prepTime => 'Prep time (min)';

  @override
  String get savingRecipe => 'Saving recipe...';

  @override
  String get recentlyAdded => 'Recently added';

  @override
  String get favoriteRecipes => 'Favorites recipes';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get search => 'Search';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteRecipe => 'Delete Recipe';

  @override
  String get deleteRecipeQuestion => 'Are you sure you want to delete this recipe?';

  @override
  String get cancel => 'Cancel';

  @override
  String get planRecipe => 'Plan Recipe';

  @override
  String get notes => 'Notes';

  @override
  String planDateQuestion(Object date) {
    return 'Do you want to add some notes for this recipe on date: $date?';
  }

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get createShoppingList => 'Create Shopping List';

  @override
  String get shoppingListName => 'Shopping List Name';

  @override
  String get create => 'Create';

  @override
  String get cleanUpShoppingLists => 'Clean up shopping lists';

  @override
  String get filterOptions => 'Filter options';

  @override
  String get maxPrepTime => 'Max prep time (min)';

  @override
  String get resetFilters => 'Reset filters';

  @override
  String get noRecipesFound => 'No recipes found';

  @override
  String get noCategoriesFound => 'No categories found';

  @override
  String get noShoppingListsFound => 'No shopping lists found';

  @override
  String get noPlanningsFound => 'No plannings found';

  @override
  String get noFavoritesFound => 'No favorite recipes found';

  @override
  String get noRecentRecipesFound => 'No recent recipes found';

  @override
  String get slogan => 'Your personalized recipes app';

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get loginToYourAccount => 'Login to your account';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get invalidEmailOrPassword => 'Invalid email or password';

  @override
  String get createNewAccount => 'Create your new account';

  @override
  String get fillAllFields => 'Please fill all fields';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get passwordRequirements => 'Password must be at least 7 characters long, contain an uppercase letter and a number';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get signupFailed => 'You can\'t cross this bridge';

  @override
  String get noIngredientsFound => 'No ingredients found';

  @override
  String get noInstructionsFound => 'No instructions found';

  @override
  String get favoire => 'Favorite';
}
