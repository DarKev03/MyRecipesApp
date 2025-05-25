import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //Buscar receta
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('Search Page'),
      ),
    );
  }
}
