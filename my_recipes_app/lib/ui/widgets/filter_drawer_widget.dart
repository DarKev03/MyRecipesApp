import 'package:flutter/material.dart';
import 'package:my_recipes_app/l10n/app_localizations.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';


class FilterDrawerWidget extends StatefulWidget {
  const FilterDrawerWidget({super.key});

  @override
  State<FilterDrawerWidget> createState() => _FilterDrawerWidgetState();
}

class _FilterDrawerWidgetState extends State<FilterDrawerWidget> {
  double _maxPreparationTime = 0;

  @override
  void initState() {
    super.initState();
    final recipeViewModel = context.read<RecipeViewModel>();
    _maxPreparationTime = recipeViewModel.maxPreparationTime;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.filterOptions,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Divider(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.category,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<RecipeViewModel>(builder: (context, viewModel, child) {
                  final categories = viewModel.categoryRecipes;
                  return categories.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return CheckboxListTile(
                              title: Text(category),
                              activeColor: AppColors.primaryColor,
                              value: viewModel.selectedCategories
                                  .contains(category),
                              onChanged: (value) {
                                setState(() {
                                  if (value!) {
                                    viewModel.setSelectedCategory(category);
                                  } else {
                                    viewModel.removeSelectedCategory(category);
                                  }
                                });
                              },
                            );
                          },
                        )
                      : const Center(
                          child: Text('No categories found'),
                        );
                }),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                // Slider de tiempo de preparacion
                Text(AppLocalizations.of(context)!.maxPrepTime,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                Slider(
                  value: _maxPreparationTime,
                  activeColor: AppColors.primaryColor,
                  min: 0,
                  max: 300,
                  divisions: 30,
                  thumbColor: AppColors.primaryColor,
                  label: _maxPreparationTime.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _maxPreparationTime = value;
                      final recipeViewModel = context.read<RecipeViewModel>();
                      recipeViewModel.setMaxPrepTime(_maxPreparationTime);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButtomWidget(
                        text: AppLocalizations.of(context)!.resetFilters,
                        onPressed: () {
                          final recipeViewModel =
                              context.read<RecipeViewModel>();
                          recipeViewModel.resetFilters();
                          setState(() {});
                          Navigator.pop(context);
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
