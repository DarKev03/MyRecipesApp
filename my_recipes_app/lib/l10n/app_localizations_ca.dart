// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get upcomingPlannings => 'Properes planificacions';

  @override
  String get name => 'Nom';

  @override
  String get category => 'Categoria';

  @override
  String get prepTime => 'Temps prep. (min)';

  @override
  String get savingRecipe => 'Guardant recepta...';

  @override
  String get recentlyAdded => 'Afegides recentment';

  @override
  String get favoriteRecipes => 'Receptes favorites';

  @override
  String get profile => 'Perfil';

  @override
  String get logout => 'Tancar sessió';

  @override
  String get search => 'Cercar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteRecipe => 'Eliminar recepta';

  @override
  String get deleteRecipeQuestion => 'Estàs segur que vols eliminar aquesta recepta?';

  @override
  String get cancel => 'Cancel·lar';

  @override
  String get planRecipe => 'Planificar recepta';

  @override
  String get notes => 'Notes';

  @override
  String planDateQuestion(Object date) {
    return 'Vols afegir alguna nota per a aquesta recepta el dia: $date?';
  }

  @override
  String get no => 'No';

  @override
  String get yes => 'Sí';

  @override
  String get createShoppingList => 'Crear llista de la compra';

  @override
  String get shoppingListName => 'Nom de la llista de la compra';

  @override
  String get create => 'Crear';

  @override
  String get cleanUpShoppingLists => 'Buidar llistes de la compra';

  @override
  String get filterOptions => 'Opcions de filtre';

  @override
  String get maxPrepTime => 'Temps màxim de preparació (min)';

  @override
  String get resetFilters => 'Reiniciar filtres';

  @override
  String get noRecipesFound => 'No s\'han trobat receptes';

  @override
  String get noCategoriesFound => 'No s\'han trobat categories';

  @override
  String get noShoppingListsFound => 'No s\'han trobat llistes de la compra';

  @override
  String get noPlanningsFound => 'No s\'han trobat planificacions';

  @override
  String get noFavoritesFound => 'No s\'han trobat receptes favorites';

  @override
  String get noRecentRecipesFound => 'No s\'han trobat receptes recents';

  @override
  String get slogan => 'La teva app de receptes personalitzades';

  @override
  String get register => 'Registrar-se';

  @override
  String get login => 'Iniciar sessió';

  @override
  String get email => 'Correu electrònic';

  @override
  String get password => 'Contrasenya';

  @override
  String get confirmPassword => 'Confirmar contrasenya';

  @override
  String get alreadyHaveAccount => 'Ja tens un compte?';

  @override
  String get welcomeBack => 'Benvingut de nou!';

  @override
  String get loginToYourAccount => 'Inicia sessió al teu compte';

  @override
  String get dontHaveAccount => 'No tens compte?';

  @override
  String get invalidEmailOrPassword => 'Correu electrònic o contrasenya incorrectes';

  @override
  String get createNewAccount => 'Crea el teu nou compte';

  @override
  String get fillAllFields => 'Si us plau, omple tots els camps';

  @override
  String get invalidEmailFormat => 'Format de correu electrònic no vàlid';

  @override
  String get passwordRequirements => 'La contrasenya ha de tenir almenys 7 caràcters, una majúscula i un número';

  @override
  String get passwordsDoNotMatch => 'Les contrasenyes no coincideixen';

  @override
  String get signupFailed => 'No pots creuar aquest pont';

  @override
  String get noIngredientsFound => 'No s\'han trobat ingredients';

  @override
  String get noInstructionsFound => 'No s\'han trobat instruccions';

  @override
  String get favoire => 'Favorit';
}
