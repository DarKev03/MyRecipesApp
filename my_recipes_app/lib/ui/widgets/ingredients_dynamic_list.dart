import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';

class IngredientsDynamicList extends StatefulWidget {
  @override
  State<IngredientsDynamicList> createState() => _IngredientsDynamicListState();
}

class _IngredientsDynamicListState extends State<IngredientsDynamicList> {
  List<TextEditingController> ingredientNameControllers = [];
  List<TextEditingController> ingredientQuantityControllers = [];
  List<TextEditingController> ingredientUnitsControllers = [];

  @override
  void initState() {
    super.initState();
    _addIngredient(); // Añadir al menos uno al principio
  }

  void _addIngredient() {
    setState(() {
      ingredientNameControllers.add(TextEditingController());
      ingredientQuantityControllers.add(TextEditingController());
      ingredientUnitsControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ingredientNameControllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: CustomTextField(
                      controller: ingredientNameControllers[index],
                      isPassword: false,
                      labelText: 'Ingredient',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      controller: ingredientQuantityControllers[index],
                      keyboardType: TextInputType.number,
                      isPassword: false,
                      labelText: 'Quantity',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomTextField(
                      controller: ingredientUnitsControllers[index],
                      isPassword: false,
                      labelText: 'Unit',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        CustomElevatedButtomWidget(
          height: 10,
          width: 100,
          text: 'Añadir ingrediente',
          onPressed: _addIngredient,
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (final c in ingredientNameControllers) c.dispose();
    for (final c in ingredientQuantityControllers) c.dispose();
    for (final c in ingredientUnitsControllers) c.dispose();
    super.dispose();
  }
}
