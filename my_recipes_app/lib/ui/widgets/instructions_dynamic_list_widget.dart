import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/instruction.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:my_recipes_app/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class InstructionsDynamicListWidget extends StatefulWidget {
  final int? recipeId;
  List<Instruction>? initialInstructions;

  InstructionsDynamicListWidget({
    super.key,
    this.recipeId,
    this.initialInstructions,
  });

  @override
  InstructionsDynamicListWidgetState createState() =>
      InstructionsDynamicListWidgetState();
}

class InstructionsDynamicListWidgetState
    extends State<InstructionsDynamicListWidget> {
  List<TextEditingController> controllers = [];
  List<int?> instructionIds = [];
  List<int?> originalInstructionIds = [];

  @override
  void initState() {
    super.initState();
    final vm = context.read<InstructionViewmodel>();
    widget.initialInstructions = vm.allInstructions
        .where((inst) => inst.recipeId == widget.recipeId)
        .toList();
    if (widget.initialInstructions != null &&
        widget.initialInstructions!.isNotEmpty) {
      for (var inst in widget.initialInstructions!) {
        controllers.add(TextEditingController(text: inst.text));
        instructionIds.add(inst.id);
      }
      originalInstructionIds = List<int?>.from(instructionIds);
    } else {
      _addInstruction();
    }
  }

  void _addInstruction() {
    setState(() {
      controllers.add(TextEditingController());
      instructionIds.add(null);
    });
  }

  void _removeInstruction(int index) async {
    final vm = context.read<InstructionViewmodel>();
    final userVm = context.read<UserViewModel>();
    if (originalInstructionIds.length > index) {
      await vm.deleteInstruction(originalInstructionIds[index]!);
      originalInstructionIds.removeAt(index);
      vm.fetchInstructionsByUserId(userVm.currentUser!.id!);
      vm.fetchInstructionsByRecipeId(widget.recipeId!);
    }
    controllers[index].dispose();
    controllers.removeAt(index);
    instructionIds.removeAt(index);
  }

  Future<void> saveInstructions(int recipeId) async {
    final vm = context.read<InstructionViewmodel>();
    List<int?> currentInstructionIds = [];

    for (int i = 0; i < controllers.length; i++) {
      final text = Validations.firstLetterUpperCase(controllers[i].text.trim());
      final id = instructionIds[i];

      if (text.isEmpty) continue;

      if (id == null) {
        await vm.addInstruction(Instruction(
          id: null,
          recipeId: recipeId,
          text: text,
        ));
        final newInst = vm.allRecipeInstructions.last;
        instructionIds[i] = newInst.id;
        currentInstructionIds.add(newInst.id);
      } else {
        // Editar existente
        await vm.updateInstruction(Instruction(
          id: id,
          recipeId: recipeId,
          text: text,
        ));
        currentInstructionIds.add(id);
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
          itemCount: controllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    _removeInstruction(index);
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
                      flex: 6,
                      child: CustomTextField(
                        controller: controllers[index],
                        isPassword: false,
                        labelText: 'Instrucción',
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: CustomElevatedButtomWidget(
            text: 'Añadir instrucción',
            onPressed: _addInstruction,
            width: MediaQuery.of(context).size.width * 0.2,
            height: 10,
          ),
        ),
      ],
    );
  }
}
