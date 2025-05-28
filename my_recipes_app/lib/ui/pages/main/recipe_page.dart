import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/recipe_calendar.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/hero_image_widget.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/instruction_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/tittle_category_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

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
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.calendar_today_outlined,
                  color: AppColors.secondaryColor,
                ),
                onPressed: () {
                  final viewModel = context.read<RecipeViewModel>();
                  final userViewModel = context.read<LoginViewModel>();

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
                        return StatefulBuilder(builder: (context, setState) {
                          return !isLoading
                              ? AlertDialog(
                                  title: const Text('Notes'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                          'Do you want to add some notes for this recipe on date: ${datePicked.day}/${datePicked.month}/${datePicked.year}?'),
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
                                      child: const Text('No'),
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await viewModel.addRecipeCalendar(
                                          RecipeCalendar(
                                            id: null,
                                            userId:
                                                userViewModel.currentUser!.id!,
                                            recipeId: recipe.id!,
                                            recipeTitle: recipe.title!,
                                            scheduledDate: datePicked,
                                            notes: null,
                                          ),
                                        );
                                        await viewModel
                                            .fetchRecipeCalendarsByUserId(
                                                userViewModel.currentUser!.id!);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pop(dialogContext);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await viewModel.addRecipeCalendar(
                                          RecipeCalendar(
                                            id: null,
                                            userId:
                                                userViewModel.currentUser!.id!,
                                            recipeId: recipe.id!,
                                            recipeTitle: recipe.title!,
                                            scheduledDate: datePicked,
                                            notes: controller.text,
                                          ),
                                        );
                                        await viewModel
                                            .fetchRecipeCalendarsByUserId(
                                                userViewModel.currentUser!.id!);
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
              ),
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
