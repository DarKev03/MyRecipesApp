class RecipeCalendar {
  final int id;
  final int userId;
  final int recipeId;
  final DateTime scheduledDate;
  final String? notes;
  final DateTime createdAt;

  RecipeCalendar({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.scheduledDate,
    this.notes,
    required this.createdAt,
  });

  factory RecipeCalendar.fromJson(Map<String, dynamic> json) => RecipeCalendar(
        id: json['id'],
        userId: json['user_id'],
        recipeId: json['recipe_id'],
        scheduledDate: DateTime.parse(json['scheduled_date']),
        notes: json['notes'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'recipe_id': recipeId,
        'scheduled_date': scheduledDate.toIso8601String(),
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
      };
}
