class RecipeCalendar {
  final int? id;
  final int? userId;
  final int? recipeId;
  final String? recipeTitle;
  final DateTime? scheduledDate;
  final String? notes;
  final DateTime? createdAt;

  RecipeCalendar({
    required this.id,
    this.userId,
    this.recipeId,
    this.recipeTitle,
    this.scheduledDate,
    this.notes,
    this.createdAt,
  });

  factory RecipeCalendar.fromJson(Map<String, dynamic> json) => RecipeCalendar(
        id: json['id'],
        userId: json['userId'],
        recipeId: json['recipeId'],
        recipeTitle: json['recipeTitle'] ?? '',
        scheduledDate: DateTime.parse(json['scheduledDate']),
        notes: json['notes'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'recipeId': recipeId,
        'recipeTitle': recipeTitle,
        'scheduledDate': scheduledDate?.toIso8601String(),
        'notes': notes,
      };
}
