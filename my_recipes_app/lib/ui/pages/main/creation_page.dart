import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/ingredient.dart';
import 'package:my_recipes_app/data/models/instruction.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/image_uploader_widget.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_dynamic_list.dart';
import 'package:my_recipes_app/ui/widgets/instructions_dynamic_list_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class CreationPage extends StatefulWidget {
  CreationPage({super.key});

  @override
  State<CreationPage> createState() => _CreationPageState();
}

class _CreationPageState extends State<CreationPage> {
  final nameController = TextEditingController();
  final categoriaController = TextEditingController();

  int recipeId = 0;
  String? imageUrl;

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
                color:
                    imageUrl == null ? Colors.grey : AppColors.secondaryColor,
              ),
              onPressed: imageUrl == null
                  ? null
                  : () async {
                      final recipesViewmodel = context.read<RecipeViewModel>();
                      final loginViewModel = context.read<LoginViewModel>();
                      final currentUser = loginViewModel.currentUser!.id!;
                      await recipesViewmodel.addRecipe(Recipe(
                          id: null,
                          userId: currentUser,
                          category: categoriaController.text,
                          imageUrl: imageUrl,
                          isFavorite: false,
                          prepTime: null,
                          title: nameController.text,
                          createdAt: DateTime.now().toString()));
                      setState(() {
                        recipeId = recipesViewmodel.recipes.last.id!;
                      });
                      await recipesViewmodel.fetchRecipesByUser(loginViewModel.currentUser!);
                      Navigator.pop(context);
                    },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: nameController,
                isPassword: false,
                labelText: 'Name',
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: categoriaController,
                  isPassword: false,
                  labelText: 'Category'),
              SizedBox(
                height: 15,
              ),
              ImageUploaderWidget(onImageUploaded: (imageUrl) {
                setState(() {
                  this.imageUrl = imageUrl;
                });
              }),
              SizedBox(
                height: 25,
              ),
              IngredientsDynamicList(
                recipeId: recipeId,
              ),
              SizedBox(
                height: 25,
              ),
              InstructionsDynamicListWidget(
                recipeId: recipeId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
