import 'package:flutter/material.dart';
import 'package:my_recipes_app/utils/AppColors.dart';
import 'package:my_recipes_app/viewmodels/instruction_viewmodel.dart';
import 'package:provider/provider.dart';

class InstructionListWidget extends StatelessWidget {
  const InstructionListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InstructionViewmodel>(
      builder: (context, viewModel, child) {
        final instructions = viewModel.instructions;
        return instructions.isNotEmpty
            ? ListView.builder(                
                itemCount: instructions.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final instruction = instructions[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.secondaryColor,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    title: Text(instruction.text,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryColor)),
                  );
                },
              )
            : Center(
                child: Text(
                  'No instructions available',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
      },
    );
  }
}
