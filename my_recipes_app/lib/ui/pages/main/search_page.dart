import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/custom_gridBuilder_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/filter_drawer_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController queryController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.filter_alt_sharp,
                  color: AppColors.secondaryColor,
                ),
                onPressed: () {
                  //Filtros
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ),
          ],
        ),
        endDrawer: FilterDrawerWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomTextField(
                        controller: queryController,
                        isPassword: false,
                        labelText: 'Search',
                        color: AppColors.primaryColor,
                        enableSuggestions: true,
                        icon: Icons.search,
                        onChanged: (query) {
                          final recipeViewModel =
                              context.read<RecipeViewModel>();
                          recipeViewModel.filterRecipes(query);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomGridBuilderWidget(index: 0),
                  ]),
            ),
          ),
        ));
  }
}
