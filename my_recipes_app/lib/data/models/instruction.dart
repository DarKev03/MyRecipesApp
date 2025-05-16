class Instruction {
  final int id;
  final int recipeId;
  final String text;

  Instruction({required this.id, required this.recipeId, required this.text});

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
        id: json['id'],
        recipeId: json['recipe_id'],
        text: json['text'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipe_id': recipeId,
        'text': text,
      };
}
