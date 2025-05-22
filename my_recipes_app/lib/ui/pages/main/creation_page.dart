import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/ui/widgets/ingredients_dynamic_list.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class CreationPage extends StatelessWidget {
  final nameController = TextEditingController();
  final categoriaController = TextEditingController();

  CreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(
                Icons.save_outlined,
                size: 30,
                color: AppColors.secondaryColor,
              ),
              onPressed: () {
                //Agendar receta
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(        
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                controller: nameController,
                isPassword: false,
                labelText: 'Name',
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                  controller: categoriaController,
                  isPassword: false,
                  labelText: 'Category'),
              SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    // Implementar la funcionalidad para añadir una foto
                  },
                  icon: Icon(Icons.photo_camera, color: Colors.white),
                  label: Text('Imagen', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  )),
              SizedBox(
                height: 25,
              ),
              IngredientsDynamicList(),
            ],
          ),
        ),
      ),
    );
  }
}
