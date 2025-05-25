class Instruction {
  final int? id;
  final int? recipeId;
  final String text;
  final int? userId;

  Instruction({required this.id, required this.recipeId, required this.text, this.userId});

  factory Instruction.fromJson(Map<String, dynamic> json) => Instruction(
        id: json['id'],
        recipeId: json['recipeId'],
        text: json['text'],
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'recipeId': recipeId,
        'text': text,
      };
}
