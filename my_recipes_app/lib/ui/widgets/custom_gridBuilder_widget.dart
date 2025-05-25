import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/pages/main/recipe_page.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomGridBuilderWidget extends StatefulWidget {
  final int index;
  const CustomGridBuilderWidget({super.key, required this.index});

  @override
  State<CustomGridBuilderWidget> createState() =>
      _CustomGridBuilderWidgetState();
}

class _CustomGridBuilderWidgetState extends State<CustomGridBuilderWidget> {
  bool _isHover = false;
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeViewModel>(
      builder: (context, viewModel, child) {
        final recetas = widget.index == 0
            ? viewModel.filteredRecipes
            : viewModel.favoriteRecipes;
        return recetas.isNotEmpty
            ? GridView.builder(
                padding: EdgeInsets.only(bottom: 40),
                shrinkWrap: true,
                itemCount: recetas.length,
                physics: const NeverScrollableScrollPhysics(),
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
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipePage(
                            recipe: recipe,
                          ),
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
                              recipe.title!,
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
              )
            : Center(
                child: widget.index == 0
                    ? Text('No recipes found')
                    : Text(
                        'No favorite recipes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
              );
      },
    );
  }
}
