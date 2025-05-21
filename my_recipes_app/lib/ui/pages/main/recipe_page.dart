import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/ui/widgets/hero_image_widget.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/instruction_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/tittle_category_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
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
      final ingredientViewModel = context.read<IngredientViewmodel>();

      recipeViewModel.setRecipe(widget.recipe);
      instructionViewModel.fetchInstructionsByRecipeId(widget.recipe.id);
      ingredientViewModel.fetchIngredientsByRecipe(widget.recipe);
    });
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
                icon: const Icon(Icons.calendar_today_outlined, color: AppColors.secondaryColor,),
                onPressed: () {
                  //Agendar receta
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
              IngredientsListWidget(),

              //Lista de instrucciones
              InstructionListWidget(),
                            
            ],
          ),
        ));
  }
}
