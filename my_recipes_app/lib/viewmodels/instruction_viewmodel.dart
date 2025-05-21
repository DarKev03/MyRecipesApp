import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/instruction.dart';
import 'package:my_recipes_app/data/repositories/instruction_repository.dart';

class InstructionViewmodel extends ChangeNotifier {
  final InstructionRepository instructionRepository;
  List<Instruction> _instructions = [];

  List<Instruction> get instructions => _instructions;

  InstructionViewmodel({required this.instructionRepository});

  Future<void> fetchInstructionsByRecipeId(int recipeId) async {
    try {
      _instructions = await instructionRepository.getInstructionsByRecipeId(recipeId);
      notifyListeners();
    } catch (e) {
      print("Error fetching instructions: $e");
    }
  }
}
