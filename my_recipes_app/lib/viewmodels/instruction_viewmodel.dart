import 'package:flutter/material.dart';
import 'package:my_recipes_app/data/models/instruction.dart';
import 'package:my_recipes_app/data/repositories/instruction_repository.dart';

class InstructionViewmodel extends ChangeNotifier {
  final InstructionRepository instructionRepository;
  List<Instruction> _allInstructions = [];
  List<Instruction> get allRecipeInstructions => _allInstructions;

  List<Instruction> get allInstructions => _allInstructions;

  InstructionViewmodel({required this.instructionRepository});

  Future<void> fetchInstructionsByRecipeId(int recipeId) async {
    try {
      _allInstructions =
          await instructionRepository.getInstructionsByRecipeId(recipeId);
      notifyListeners();
    } catch (e) {
      print("Error fetching instructions: $e");
    }
  }

  void getRecipeInstructions(int recipeId) {
    _allInstructions = _allInstructions
        .where((instruction) => instruction.recipeId == recipeId)
        .toList();
  }

  Future<void> fetchInstructionsByUserId(int userId) async {
    try {
      _allInstructions =
          await instructionRepository.getInstructionsByUserId(userId);
      notifyListeners();
    } catch (e) {
      print("Error fetching instructions: $e");
    }
  }

  Future<void> addInstruction(Instruction instruction) async {
    try {
      final finalInstruction =
          await instructionRepository.createInstruction(instruction);
      _allInstructions.add(finalInstruction);
      notifyListeners();
    } catch (e) {
      print("Error adding instruction: $e");
    }
  }

  Future<void> deleteInstruction(int id) async {
    try {
      await instructionRepository.deleteInstruction(id);
      _allInstructions.removeWhere((instruction) => instruction.id == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting instruction: $e");
    }
  }

  Future<void> updateInstruction(Instruction instruction) async {
    try {
      final updatedInstruction =
          await instructionRepository.updateInstruction(instruction);
      final index = _allInstructions
          .indexWhere((inst) => inst.id == updatedInstruction.id);
      if (index != -1) {
        _allInstructions[index] = updatedInstruction;
        notifyListeners();
      }
    } catch (e) {
      print("Error updating instruction: $e");
    }
  }
}
