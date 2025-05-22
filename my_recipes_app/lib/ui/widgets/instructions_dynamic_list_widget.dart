import 'package:flutter/material.dart';
import 'package:my_recipes_app/ui/widgets/custom_elevated_buttom_widget.dart';
import 'package:my_recipes_app/ui/widgets/custom_text_field.dart';
import 'package:my_recipes_app/utils/AppColors.dart';

class InstructionsDynamicListWidget extends StatefulWidget {
  const InstructionsDynamicListWidget({super.key});

  @override
  State<InstructionsDynamicListWidget> createState() =>
      _InstructionsDynamicListWidgetState();
}

class _InstructionsDynamicListWidgetState
    extends State<InstructionsDynamicListWidget> {
  final List<TextEditingController> instructionsControllers = [];

  @override
  void initState() {
    super.initState();
    _addInstruction();
  }

  void _addInstruction() {
    setState(() {
      instructionsControllers.add(TextEditingController());
    });
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
                    color: AppColors.primaryColor
                  ),
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
              text: 'Add instruction', onPressed: _addInstruction, width: 110, height: 10,),
        ),
      ],
    );
  }
}
