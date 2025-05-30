import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/recipe_ingredient.dart';
import 'package:my_recipes_app/data/models/ingredient.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/ingredient_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class IngredientsDynamicList extends StatefulWidget {
  final int? recipeId;
  List<RecipeIngredient>? initialIngredients;

  IngredientsDynamicList({
    super.key,
    this.recipeId,
    this.initialIngredients,
  });

  @override
  IngredientsDynamicListState createState() => IngredientsDynamicListState();
}

class IngredientsDynamicListState extends State<IngredientsDynamicList> {
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> quantityControllers = [];
  List<TextEditingController> unitControllers = [];
  List<int?> recipeIngredientIds = [];
  List<int?> ingredientIds = [];
  List<int?> originalRecipeIngredientIds = [];

  @override
  void initState() {
    super.initState();
    final vm = context.read<IngredientViewmodel>();
    widget.initialIngredients = vm.allUserIngredients
        .where((ri) => ri.recipeId == widget.recipeId)
        .toList();
    if (widget.initialIngredients != null &&
        widget.initialIngredients!.isNotEmpty) {
      for (var ri in widget.initialIngredients!) {
        nameControllers.add(TextEditingController(text: ri.ingredientName));
        quantityControllers
            .add(TextEditingController(text: ri.quantity?.toString() ?? ''));
        unitControllers.add(TextEditingController(text: ri.unit ?? ''));
        recipeIngredientIds.add(ri.id);
        ingredientIds.add(ri.ingredientId);
      }
      originalRecipeIngredientIds = List<int?>.from(recipeIngredientIds);
    } else {
      _addIngredient();
    }
  }

  void _addIngredient() {
    setState(() {
      nameControllers.add(TextEditingController());
      quantityControllers.add(TextEditingController());
      unitControllers.add(TextEditingController());
      recipeIngredientIds.add(null);
      ingredientIds.add(null);
    });
  }

  void _removeIngredient(int index) {
    if (originalRecipeIngredientIds.length > index &&
        originalRecipeIngredientIds[index] != null) {
      final vm = context.read<IngredientViewmodel>();
      final userVm = context.read<LoginViewModel>();
      vm.deleteRecipeIngredient(originalRecipeIngredientIds[index]!);
      originalRecipeIngredientIds.removeAt(index);
      vm.fetchIngredientsByUserId(userVm.currentUser!.id!);
      vm.fetchIngredientsByRecipeId(widget.recipeId!);
    }
    nameControllers[index].dispose();
    quantityControllers[index].dispose();
    unitControllers[index].dispose();
    nameControllers.removeAt(index);
    quantityControllers.removeAt(index);
    unitControllers.removeAt(index);
    recipeIngredientIds.removeAt(index);
    ingredientIds.removeAt(index);
  }

  Future<void> saveIngredients(int recipeId) async {
    final vm = context.read<IngredientViewmodel>();
    List<int?> currentRecipeIngredientIds = [];

    for (int i = 0; i < nameControllers.length; i++) {
      final name =
          Validations.firstLetterUpperCase(nameControllers[i].text.trim());
      final quantity = double.tryParse(quantityControllers[i].text);
      final unit = unitControllers[i].text.trim();
      final recipeIngId = recipeIngredientIds[i];
      final ingredientId = ingredientIds[i];

      if (name.isEmpty) continue;

      int usedIngredientId = ingredientId ??
          (await vm.addIngredient(Ingredient(
            id: null,
            name: name,
            description: null,
            createdAt: null,
          )))
              .id!;

      if (recipeIngId == null) {
        await vm.addRecipeIngredient(RecipeIngredient(
          id: null,
          recipeId: recipeId,
          ingredientName: name,
          ingredientId: usedIngredientId,
          quantity: quantity,
          unit: unit,
        ));
        await vm.fetchIngredientsByRecipeId(recipeId);
        final newRecipeIng = vm.allUserIngredients.last;

        recipeIngredientIds[i] = newRecipeIng.id;
        ingredientIds[i] = usedIngredientId;
        currentRecipeIngredientIds.add(newRecipeIng.id);
      } else {
        // Actualizar existente
        await vm.updateRecipeIngredient(RecipeIngredient(
          id: recipeIngId,
          recipeId: recipeId,
          ingredientName: name,
          ingredientId: usedIngredientId,
          quantity: quantity,
          unit: unit,
        ));
        currentRecipeIngredientIds.add(recipeIngId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: nameControllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    _removeIngredient(index);
                  });
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: CustomTextField(
                        controller: nameControllers[index],
                        isPassword: false,
                        labelText: 'Ingrediente',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: CustomTextField(
                        controller: quantityControllers[index],
                        keyboardType: TextInputType.number,
                        isPassword: false,
                        labelText: 'Cantidad',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: CustomTextField(
                        controller: unitControllers[index],
                        isPassword: false,
                        labelText: 'Unidad',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        CustomElevatedButtomWidget(
          height: 10,
          width: 150,
          text: 'Añadir ingrediente',
          onPressed: _addIngredient,
        ),
      ],
    );
  }
}
