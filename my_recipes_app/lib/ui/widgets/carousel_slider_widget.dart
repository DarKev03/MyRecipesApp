import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/ui/pages/main/recipe_page.dart';
import 'package:my_recipes_app/viewmodels/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  bool _isHover = false;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Consumer<HomePageViewModel>(
        builder: (context, viewModel, child) {
          List<Recipe> recipes = viewModel.recentlyRecipes;
          return viewModel.recentlyRecipes.isEmpty
              ? const Center(
                  child: Text(
                    'No recently added recipes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                )
              : CarouselSlider(
                  items: recipes.map((recipe) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(25),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTapDown: (details) {
                        setState(() {
                          _isHover = true;
                        });
                      },
                      onTapUp: (details) {
                        setState(() {
                          _isHover = false;
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          _isHover = false;
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
                        elevation:
                            _isHover && recipes.indexOf(recipe) == _currentIndex
                                ? 7
                                : 4,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              recipe.imageUrl ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.2),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    recipe.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4,
                                          color: Colors.black,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    initialPage: 0,
                    viewportFraction: 0.7,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ));
        },
      ),
    );
  }
}
