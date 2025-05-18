import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';

class FavoritesRecipesWidget extends StatelessWidget {
  final List<Recipe> recetas = [
    Recipe(
      id: 1,
      title: 'Spaghetti Carbonara',
      imageUrl:
          "https://images.unsplash.com/photo-1608756687911-aa1599ab3bd9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      description: 'A classic Italian pasta dish.',
      userId: 0,
      createdAt: DateTime.now(),
    ),
    Recipe(
      id: 2,
      title: 'Chicken Curry',
      imageUrl:
          "https://images.unsplash.com/photo-1608756687911-aa1599ab3bd9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      description: 'A spicy and flavorful dish.',
      userId: 0,
      createdAt: DateTime.now(),
    ),
    Recipe(
      id: 3,
      title: 'Tiramisu',
      imageUrl:
          "https://images.unsplash.com/photo-1608756687911-aa1599ab3bd9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      description: 'An Italian dessert.',
      userId: 0,
      createdAt: DateTime.now(),
    ),
    Recipe(
      id: 4,
      title: 'Beef Stroganoff',
      imageUrl:
          "https://images.unsplash.com/photo-1608756687911-aa1599ab3bd9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      description: 'A hearty Russian dish.',
      userId: 0,
      createdAt: DateTime.now(),
    ),
  ];
  FavoritesRecipesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: GridView.builder(
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
      ),
    );
  }
}
