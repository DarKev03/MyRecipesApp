// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get upcomingPlannings => 'Próximas planificaciones';

  @override
  String get name => 'Nombre';

  @override
  String get category => 'Categoría';

  @override
  String get prepTime => 'Tiempo prep. (min)';

  @override
  String get savingRecipe => 'Guardando receta...';

  @override
  String get recentlyAdded => 'Añadidas recientemente';

  @override
  String get favoriteRecipes => 'Recetas favoritas';

  @override
  String get profile => 'Perfil';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get search => 'Buscar';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteRecipe => 'Eliminar receta';

  @override
  String get deleteRecipeQuestion => '¿Estás seguro de que quieres eliminar esta receta?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get planRecipe => 'Planificar receta';

  @override
  String get notes => 'Notas';

  @override
  String planDateQuestion(Object date) {
    return '¿Quieres añadir alguna nota para esta receta el día: $date?';
  }

  @override
  String get no => 'No';

  @override
  String get yes => 'Sí';

  @override
  String get createShoppingList => 'Crear lista de la compra';

  @override
  String get shoppingListName => 'Nombre de la lista de la compra';

  @override
  String get create => 'Crear';

  @override
  String get cleanUpShoppingLists => 'Vaciar listas de la compra';

  @override
  String get filterOptions => 'Opciones de filtro';

  @override
  String get maxPrepTime => 'Tiempo máximo de preparación (min)';

  @override
  String get resetFilters => 'Reiniciar filtros';

  @override
  String get noRecipesFound => 'No se han encontrado recetas';

  @override
  String get noCategoriesFound => 'No se han encontrado categorías';

  @override
  String get noShoppingListsFound => 'No se han encontrado listas de la compra';

  @override
  String get noPlanningsFound => 'No se han encontrado planificaciones';

  @override
  String get noFavoritesFound => 'No se han encontrado recetas favoritas';

  @override
  String get noRecentRecipesFound => 'No se han encontrado recetas recientes';

  @override
  String get slogan => 'Tu app de recetas personalizadas';

  @override
  String get register => 'Registrarse';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get welcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get loginToYourAccount => 'Inicia sesión en tu cuenta';

  @override
  String get dontHaveAccount => '¿No tienes cuenta?';

  @override
  String get invalidEmailOrPassword => 'Correo electrónico o contraseña incorrectos';

  @override
  String get createNewAccount => 'Crea tu nueva cuenta';

  @override
  String get fillAllFields => 'Por favor, rellena todos los campos';

  @override
  String get invalidEmailFormat => 'Formato de correo electrónico no válido';

  @override
  String get passwordRequirements => 'La contraseña debe tener al menos 7 caracteres, una mayúscula y un número';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get signupFailed => 'No puedes cruzar este puente';

  @override
  String get noIngredientsFound => 'No se han encontrado ingredientes';

  @override
  String get noInstructionsFound => 'No se han encontrado instrucciones';

  @override
  String get favoire => 'Favorito';
}
