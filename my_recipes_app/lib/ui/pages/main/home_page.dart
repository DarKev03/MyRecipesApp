import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/carousel_slider_widget.dart';
import 'package:my_recipes_app/ui/widgets/favorites_recipes_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            PopupMenuButton<String>(              
              iconColor: AppColors.secondaryColor,
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person, color: AppColors.secondaryColor),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: AppColors.secondaryColor),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: AppColors.secondaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final homePageViewModel = context.read<RecipeViewModel>();
            final loginViewModel = context.read<LoginViewModel>();
            final ingredientViewModel = context.read<IngredientViewmodel>();
            final instructionViewModel = context.read<InstructionViewmodel>();
            homePageViewModel.fetchRecipesByUser(loginViewModel.currentUser!);
            ingredientViewModel.fetchIngredientsByUserId(loginViewModel.currentUser!.id!);
            instructionViewModel.fetchInstructionsByUserId(loginViewModel.currentUser!.id!);
          },
          backgroundColor: AppColors.primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: const Text(
                  'Recently added',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              //Carrusel de imagenes
              CarouselSliderWidget(),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'Favorites recipes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // Cards de recetas favoritas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: FavoritesRecipesWidget(),
              )
            ],
          ),
        ));
  }
}
