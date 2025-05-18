class Recipe {
  final int id;
  final int userId;
  final String title;
  final String? description;
  final String? instructions;
  final int? prepTime;
  final String? imageUrl;
  final String createdAt;

  Recipe({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.imageUrl,
    this.instructions,
    this.prepTime,
    required this.createdAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'],
        userId: json['user_id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['image_url'],
        instructions: json['instructions'],
        prepTime: json['prep_time'],
        createdAt: json['created_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'instructions': instructions,
        'prep_time': prepTime,
        'created_at': createdAt,
      };
}
