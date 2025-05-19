import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/main/recipe_page.dart';
import 'package:my_recipes_app/viewmodels/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class FavoritesRecipesWidget extends StatefulWidget {
  const FavoritesRecipesWidget({super.key});

  @override
  State<FavoritesRecipesWidget> createState() => _FavoritesRecipesWidgetState();
}

class _FavoritesRecipesWidgetState extends State<FavoritesRecipesWidget> {
  bool _isHover = false;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(
      builder: (context, homePageViewModel, child) {
        final recetas = homePageViewModel.favoriteRecipes;
        return GridView.builder(
          padding: EdgeInsets.only(bottom: 40),
          shrinkWrap: true,
          itemCount: recetas.length,
          physics: recetas.length <= 4
              ? const NeverScrollableScrollPhysics()
              : const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1, // cuadradas
          ),
          itemBuilder: (context, index) {
            final recipe = recetas[index];

            return InkWell(
              borderRadius: BorderRadius.circular(25),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTapDown: (details) {
                setState(() {
                  _isHover = true;
                  _selectedIndex = index;
                });
              },
              onTapUp: (details) {
                setState(() {
                  _isHover = false;
                  _selectedIndex = -1;
                });
              },
              onTapCancel: () {
                setState(() {
                  _isHover = false;
                  _selectedIndex = -1;
                });
              },
              onTap: () {
                // Navigate to the recipe details page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(recipe: recipe),
                  ),
                );
              },
              child: Card(
                elevation: _isHover && _selectedIndex == index ? 7 : 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      recipe.imageUrl ?? '',
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
                        recipe.title,
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
