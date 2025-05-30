import 'package:my_recipes_app/data/models/instruction.dart';
import 'package:my_recipes_app/data/services/instruction_service.dart';

class InstructionRepository {
  InstructionService instructionService = InstructionService();

  Future<List<Instruction>> getInstructionsByRecipeId(int recipeId) async {
    return await instructionService.getInstructionsByRecipeId(recipeId);
  }

  Future<Instruction> createInstruction(Instruction instruction) async {
    return await instructionService.createInstruction(instruction);
  }

  Future<void> deleteInstruction(int id) async {
    return await instructionService.deleteInstruction(id);
  }

  Future<List<Instruction>> getInstructionsByUserId(int userId) async {
    return await instructionService.getInstructionsByUserId(userId);
  }

  Future<Instruction> updateInstruction(Instruction instruction) async {
    return await instructionService.updateInstruction(instruction);
  }
}
