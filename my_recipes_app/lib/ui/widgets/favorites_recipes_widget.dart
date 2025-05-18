import 'package:flutter/material.dart';
import 'package:my_recipes_app/viewmodels/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class FavoritesRecipesWidget extends StatelessWidget {  
  const FavoritesRecipesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, homePageViewModel, child) {
        final recetas = homePageViewModel.favoriteRecipes;
        return GridView.builder(
          padding: EdgeInsets.only(bottom: 40),
          shrinkWrap: true,
          itemCount: recetas.length,
          physics: recetas.length <= 4? const NeverScrollableScrollPhysics(): const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1, // cuadradas
          ),
          itemBuilder: (context, index) {
            final receta = recetas[index];

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  children: [
                    Image.network(
                      receta.imageUrl ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        receta.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
