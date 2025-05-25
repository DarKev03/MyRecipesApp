import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/instruction.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/utils/validations.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:provider/provider.dart';

class InstructionsDynamicListWidget extends StatefulWidget {
  int? recipeId;
  InstructionsDynamicListWidget({super.key, this.recipeId});

  @override
  State<InstructionsDynamicListWidget> createState() =>
      _InstructionsDynamicListWidgetState();
}

class _InstructionsDynamicListWidgetState
    extends State<InstructionsDynamicListWidget> {
  List<TextEditingController> instructionsControllers = [];

  @override
  void initState() {
    super.initState();
    _addInstruction();
  }

  @override
  void didUpdateWidget(covariant InstructionsDynamicListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.recipeId != widget.recipeId) {
      _saveInstructions();
    }
  }

  void _addInstruction() {
    setState(() {
      instructionsControllers.add(TextEditingController());
    });
  }

  void _removeInstruction() {
    for (var element in instructionsControllers) {
      element.dispose();
    }

    instructionsControllers = [];
  }

  void _saveInstructions() async {
    if (widget.recipeId != null) {
      List<Instruction> instructions = [];
      final recipesInstructionsViewmodel = context.read<InstructionViewmodel>();
      for (int i = 0; i < instructionsControllers.length; i++) {
        if (instructionsControllers[i].text.isEmpty) {
          return;
        }
        var name =
            Validations.firstLetterUpperCase(instructionsControllers[i].text);
        instructions.add(Instruction(
          id: null,
          recipeId: widget.recipeId,
          text: name,
        ));
      }
      for (var instruction in instructions) {
        await recipesInstructionsViewmodel.addInstruction(instruction);
      }

      _removeInstruction();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: instructionsControllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    instructionsControllers.removeAt(index);
                  });
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: CustomTextField(
                        controller: instructionsControllers[index],
                        isPassword: false,
                        labelText: 'Instruction',
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
            text: 'Add instruction',
            onPressed: _addInstruction,
            width: 110,
            height: 10,
          ),
        ),
      ],
    );
  }
}
