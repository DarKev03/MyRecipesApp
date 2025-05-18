import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';

class FavoritesRecipesWidget extends StatelessWidget {  
  final List<Recipe> recetas = [];
  FavoritesRecipesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 40),
      shrinkWrap: true,        
      itemCount: recetas.length,
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
  }
}
