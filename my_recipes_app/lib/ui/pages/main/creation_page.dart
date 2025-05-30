import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:my_recipes_app/data/models/instruction.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/image_uploader_widget.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_dynamic_list.dart';
import 'package:my_recipes_app/ui/widgets/instructions_dynamic_list_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreationPage extends StatefulWidget {
  final Recipe? recipeToEdit;
  List<RecipeIngredient>? initialIngredients;
  List<Instruction>? initialInstructions;

  CreationPage({
    super.key,
    this.recipeToEdit,
    this.initialIngredients,
    this.initialInstructions,
  });

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  final nameController = TextEditingController();
  final categoriaController = TextEditingController();
  final prepTimeController = TextEditingController();

  final imagePlaceHolder =
      'https://ysccfnuyictzgvydbbaq.supabase.co/storage/v1/object/public/recipes/images/sin_imagen.png';

  int? recipeId;
  String? imageUrl;
  bool isLoading = false;

  final GlobalKey<IngredientsDynamicListState> _ingredientsKey = GlobalKey();
  final GlobalKey<InstructionsDynamicListWidgetState> _instructionsKey =
      GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.recipeToEdit != null) {
      nameController.text = widget.recipeToEdit!.title!;
      categoriaController.text = widget.recipeToEdit!.category!;
      prepTimeController.text = widget.recipeToEdit!.prepTime?.toString() ?? '';
      imageUrl = widget.recipeToEdit!.imageUrl;
      recipeId = widget.recipeToEdit!.id!;
    }
  }

  bool isValidToSend() {
    return nameController.text.isNotEmpty &&
        categoriaController.text.isNotEmpty;
  }

  Future<void> _saveAll() async {
    setState(() => isLoading = true);
    final recipesViewmodel = context.read<RecipeViewModel>();
    final loginViewModel = context.read<LoginViewModel>();
    final name = Validations.firstLetterUpperCase(nameController.text);
    final category = Validations.firstLetterUpperCase(categoriaController.text);
    final currentUser = loginViewModel.currentUser!.id!;

    Recipe? savedRecipe;

    if (widget.recipeToEdit == null) {
      // CREAR NUEVA RECETA
      await recipesViewmodel.addRecipe(
        Recipe(
          id: null,
          userId: currentUser,
          category: category,
          imageUrl: imageUrl ?? imagePlaceHolder,
          isFavorite: false,
          prepTime: int.tryParse(prepTimeController.text),
          title: name,
          createdAt: DateTime.now().toString(),
        ),
      );
      savedRecipe = recipesViewmodel.recipes.last;
      recipeId = savedRecipe.id!;
    } else {
      // EDITAR RECETA EXISTENTE
      await recipesViewmodel.updateRecipe(
        Recipe(
          id: recipeId!,
          userId: currentUser,
          category: category,
          imageUrl: imageUrl ?? imagePlaceHolder,
          isFavorite: widget.recipeToEdit!.isFavorite,
          prepTime: int.tryParse(prepTimeController.text),
          title: name,
          createdAt: widget.recipeToEdit!.createdAt,
        ),
      );
      savedRecipe = widget.recipeToEdit!;
    }

    // Guardar ingredientes e instrucciones
    await _ingredientsKey.currentState?.saveIngredients(recipeId!);
    await _instructionsKey.currentState?.saveInstructions(recipeId!);

    await recipesViewmodel.fetchRecipesByUser(loginViewModel.currentUser!);

    setState(() => isLoading = false);
    Navigator.pop(context);
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
              onPressed: isValidToSend() ? _saveAll : null,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
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
                    labelText: AppLocalizations.of(context)!.name,
                    onChanged: (text) => setState(() {}),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          onChanged: (text) => setState(() {}),
                          controller: categoriaController,
                          isPassword: false,
                          labelText: AppLocalizations.of(context)!.category,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          labelText: AppLocalizations.of(context)!.prepTime,
                          controller: prepTimeController,
                          isPassword: false,
                        ),
                      ),
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
                    key: _ingredientsKey,
                    recipeId: recipeId,
                    initialIngredients: widget.initialIngredients,
                  ),
                  SizedBox(height: 25),
                  InstructionsDynamicListWidget(
                    key: _instructionsKey,
                    recipeId: recipeId,
                    initialInstructions: widget.initialInstructions,
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
                      color: Colors.black.withOpacity(0.15),
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
                          AppLocalizations.of(context)!.savingRecipe,
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
