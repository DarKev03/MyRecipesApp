import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/recipe_calendar.dart';
import 'package:my_recipes_app/ui/pages/main/creation_page.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/hero_image_widget.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/instruction_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/tittle_category_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  final TextEditingController controller = TextEditingController();
  RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.secondaryColor,
              ),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<String>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreationPage(
                              initialIngredients: [],
                              initialInstructions: [],
                              recipeToEdit: recipe,
                            ),
                          ));
                    },
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(Icons.edit, color: AppColors.secondaryColor),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.edit,
                          style: TextStyle(color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: () {
                      final viewModel = context.read<RecipeViewModel>();
                      final userViewModel = context.read<UserViewModel>();
                      final ingredientsViewModel =
                          context.read<IngredientViewmodel>();
                      final instructionViewModel =
                          context.read<InstructionViewmodel>();

                      // Eliminar receta
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.deleteRecipe),
                            content: Text(AppLocalizations.of(context)!
                                .deleteRecipeQuestion),
                            actions: [
                              TextButton(
                                child:
                                    Text(AppLocalizations.of(context)!.cancel),
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                              ),
                              TextButton(
                                child: Text(
                                    AppLocalizations.of(context)!.deleteRecipe),
                                onPressed: () async {
                                  // Eliminar receta
                                  await viewModel.deleteRecipe(recipe.id!);
                                  // Actualizar recetas del usuario
                                  await viewModel.fetchRecipesByUser(
                                      userViewModel.currentUser!);
                                  // Actualizar ingredientes
                                  await ingredientsViewModel
                                      .fetchIngredientsByUserId(
                                          userViewModel.currentUser!.id!);
                                  // Actualizar instrucciones
                                  await instructionViewModel
                                      .fetchInstructionsByUserId(
                                          userViewModel.currentUser!.id!);
                                  // Actualizar calendarios
                                  await viewModel.fetchRecipeCalendarsByUserId(
                                      userViewModel.currentUser!.id!);

                                  Navigator.pop(dialogContext);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete,
                            color: AppColors.secondaryColor),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.delete,
                          style: TextStyle(color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      final viewModel = context.read<RecipeViewModel>();
                      final userViewModel = context.read<UserViewModel>();

                      // Elegir fecha para planificación
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ).then((value) {
                        if (value == null) return;

                        DateTime datePicked =
                            DateTime(value.year, value.month, value.day);

                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            final TextEditingController controller =
                                TextEditingController();
                            bool isLoading = false;
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return !isLoading
                                  ? AlertDialog(
                                      title: Text(
                                          AppLocalizations.of(context)!.notes),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(AppLocalizations.of(context)!
                                              .planDateQuestion(datePicked
                                                  .toLocal()
                                                  .toString()
                                                  .split(' ')[0])),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomTextField(
                                            controller: controller,
                                            isPassword: false,
                                            labelText: 'Notes',
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text(
                                              AppLocalizations.of(context)!.no),
                                          onPressed: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await viewModel.addRecipeCalendar(
                                              RecipeCalendar(
                                                id: null,
                                                userId: userViewModel
                                                    .currentUser!.id!,
                                                recipeId: recipe.id!,
                                                recipeTitle: recipe.title!,
                                                scheduledDate: datePicked,
                                                notes: null,
                                              ),
                                            );
                                            await viewModel
                                                .fetchRecipeCalendarsByUserId(
                                                    userViewModel
                                                        .currentUser!.id!);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pop(dialogContext);
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .yes),
                                          onPressed: () async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await viewModel.addRecipeCalendar(
                                              RecipeCalendar(
                                                id: null,
                                                userId: userViewModel
                                                    .currentUser!.id!,
                                                recipeId: recipe.id!,
                                                recipeTitle: recipe.title!,
                                                scheduledDate: datePicked,
                                                notes: controller.text,
                                              ),
                                            );
                                            await viewModel
                                                .fetchRecipeCalendarsByUserId(
                                                    userViewModel
                                                        .currentUser!.id!);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Navigator.pop(dialogContext);
                                          },
                                        ),
                                      ],
                                    )
                                  : AlertDialog(
                                      content: SizedBox(
                                      height: 30,
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaX: 5, sigmaY: 5)),
                                            const CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                            });
                          },
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: AppColors.secondaryColor),
                        SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.planRecipe,
                          style: TextStyle(color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                  )
                ];
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              //Imagen de la receta
              HeroImageWidget(
                recipe: recipe,
              ),

              SizedBox(
                height: 10,
              ),

              //Titulo y categoria
              TitleCategoryWidget(
                recipe: recipe,
              ),

              SizedBox(
                height: 20,
              ),

              //Lista de ingredientes
              IngredientsListWidget(
                recipe: recipe,
              ),

              //Lista de instrucciones
              InstructionListWidget(
                recipe: recipe,
              ),
            ],
          ),
        ));
  }
}
