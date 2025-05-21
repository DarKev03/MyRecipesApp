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
}
