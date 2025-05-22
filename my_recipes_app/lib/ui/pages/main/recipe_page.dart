import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/ui/widgets/hero_image_widget.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/instruction_list_widget.dart';
import 'package:my_recipes_app/ui/widgets/tittle_category_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

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
              HeroImageWidget(recipe: recipe,),

              SizedBox(
                height: 10,
              ),

              //Titulo y categoria
              TitleCategoryWidget(recipe: recipe,),

              SizedBox(
                height: 20,
              ),

              //Lista de ingredientes
              IngredientsListWidget(recipe: recipe,),

              //Lista de instrucciones
              InstructionListWidget(recipe: recipe,),
            ],
          ),
        ));
  }
}
