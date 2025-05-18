class Recipe {
  final int id;
  final int? userId;
  final String title;
  final String? description;
  final String? instructions;
  final int? prepTime;
  final String? imageUrl;
  final bool? isFavorite;
  final String? createdAt;

  Recipe({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.imageUrl,
    this.instructions,
    this.isFavorite,
    this.prepTime,
    required this.createdAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'],
        userId: json['user_id'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['imageUrl'],
        instructions: json['instructions'],
        isFavorite: json['favorite'],
        prepTime: json['prepTime'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'instructions': instructions,
        'is_favorite': isFavorite,
        'prep_time': prepTime,
        'created_at': createdAt,
      };
}
