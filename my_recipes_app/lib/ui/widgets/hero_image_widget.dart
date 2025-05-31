import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeroImageWidget extends StatelessWidget {
  final Recipe recipe;
  const HeroImageWidget({
    super.key,
    required this.recipe,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeViewModel>(builder: (context, viewModel, child) {
      final imageUrl = viewModel.recipes
          .firstWhere((r) => r.id == recipe.id, orElse: () => recipe)
          .imageUrl;
      final isFavorite =
          viewModel.favoriteRecipes.any((r) => r.id == recipe.id);

      return Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            imageUrl ?? '',
            fit: BoxFit.cover,
            height: 215,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  viewModel.toggleFavorite(recipe);
                },
                label: Text(AppLocalizations.of(context)!.favoire,
                    style: TextStyle(color: AppColors.primaryColor)),
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.primaryColor,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
