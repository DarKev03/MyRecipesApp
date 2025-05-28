import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/image_uploader_widget.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_dynamic_list.dart';
import 'package:my_recipes_app/ui/widgets/instructions_dynamic_list_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class CreationPage extends StatefulWidget {
  const CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  final nameController = TextEditingController();
  final categoriaController = TextEditingController();
  final prepTimeController = TextEditingController();

  final imagePlaceHolder =
      'https://ysccfnuyictzgvydbbaq.supabase.co/storage/v1/object/public/recipes/images/sin_imagen.png';

  int recipeId = 0;
  String? imageUrl;
  bool isLoading = false;
  bool areIngredientsSaved = false;
  bool areInstructionsSaved = false;

  bool isValidToSend() {
    return nameController.text.isNotEmpty ||
        categoriaController.text.isNotEmpty;
  }

  void checkIsAllSave() {
    if (areIngredientsSaved && areInstructionsSaved) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                Icons.save_outlined,
                size: 30,
                color: isValidToSend() ? AppColors.secondaryColor : Colors.grey,
              ),
              onPressed: !isValidToSend()
                  ? null
                  : () async {
                      setState(() {
                        isLoading = true;
                      });
                      final name =
                          Validations.firstLetterUpperCase(nameController.text);
                      final category = Validations.firstLetterUpperCase(
                          categoriaController.text);
                      final recipesViewmodel = context.read<RecipeViewModel>();
                      final loginViewModel = context.read<LoginViewModel>();
                      final currentUser = loginViewModel.currentUser!.id!;
                      await recipesViewmodel.addRecipe(Recipe(
                          id: null,
                          userId: currentUser,
                          category: category,
                          imageUrl: imageUrl ?? imagePlaceHolder,
                          isFavorite: false,
                          prepTime: int.tryParse(prepTimeController.text),
                          title: name,
                          createdAt: DateTime.now().toString()));
                      setState(() {
                        recipeId = recipesViewmodel.recipes.last.id!;
                      });
                      recipesViewmodel
                          .fetchRecipesByUser(loginViewModel.currentUser!);
                    },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // El contenido principal del formulario
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: nameController,
                    isPassword: false,
                    labelText: 'Name',
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                            onChanged: (text) {
                              setState(() {});
                            },
                            controller: categoriaController,
                            isPassword: false,
                            labelText: 'Category'),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: CustomTextField(
                              keyboardType: TextInputType.number,
                              labelText: 'Prep Time (min)',
                              controller: prepTimeController,
                              isPassword: false))
                    ],
                  ),
                  SizedBox(height: 15),
                  ImageUploaderWidget(onImageUploaded: (imageUrl) {
                    setState(() {
                      this.imageUrl = imageUrl;
                    });
                  }),
                  SizedBox(height: 25),
                  IngredientsDynamicList(
                    recipeId: recipeId,
                    onIngredientsSaved: () {
                      setState(() {
                        areIngredientsSaved = true;
                        checkIsAllSave();
                      });
                    },
                  ),
                  SizedBox(height: 25),
                  InstructionsDynamicListWidget(
                    recipeId: recipeId,
                    onInstructionsSaved: () {
                      setState(() {
                        areInstructionsSaved = true;
                        checkIsAllSave();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.15), // Le da un toque oscuro
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Guardando receta...',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
