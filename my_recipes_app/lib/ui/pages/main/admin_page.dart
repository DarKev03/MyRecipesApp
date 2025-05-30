import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/recipe_viewmodel.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String selectedType = 'users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Admin Page',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              const Text("Elige el tipo de objeto que quieres borrar",
                  style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              SegmentedButton<String>(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  splashFactory: NoSplash.splashFactory,
                ),
                segments: const [
                  ButtonSegment(value: 'users', label: Text('Users')),
                  ButtonSegment(value: 'recipes', label: Text('Recipes')),
                ],
                selected: {selectedType},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    selectedType = newSelection.first;
                  });
                },
              ),
              const SizedBox(height: 30),
              CustomElevatedButtomWidget(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final rVM = context.read<RecipeViewModel>();                      
                      final uVM = context.read<UserViewModel>();

                      final controller = TextEditingController();
                      return AlertDialog(
                        title: Text('Borrar $selectedType'),
                        content: TextField(
                          keyboardType: TextInputType.number,
                          controller: controller,
                          decoration: const InputDecoration(
                            labelText: 'Introduce el ID a borrar',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              int id = int.tryParse(controller.text) ?? -1;
                              if (selectedType == 'users') {
                                uVM.deleteUser(id);
                              } else if (selectedType == 'recipes') {
                                rVM.deleteRecipe(id);
                              }
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Borrado $selectedType con id $id')),
                              );
                            },
                            child: const Text('Borrar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                text: 'Borrar $selectedType',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
