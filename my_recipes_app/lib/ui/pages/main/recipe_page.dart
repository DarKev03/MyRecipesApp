import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/ui/widgets/hero_image_widget.dart';
import 'package:my_recipes_app/ui/widgets/instruction_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/tittle_category_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final recipeViewModel = context.read<RecipeViewModel>();
      final instructionViewModel = context.read<InstructionViewmodel>();

      recipeViewModel.setRecipe(widget.recipe);
      instructionViewModel.fetchInstructionsByRecipeId(widget.recipe.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            //Imagen de la receta
            HeroImageWidget(),

            SizedBox(
              height: 10,
            ),

            //Titulo y categoria
            TitleCategoryWidget(),

            SizedBox(
              height: 20,
            ),

            //Lista de ingredientes
            Expanded(child: InstructionListWidget()),
            //Lista de instrucciones

            //Boton guardar
          ],
        ));
  }
}
