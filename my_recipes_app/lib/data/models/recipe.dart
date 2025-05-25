class Recipe {
  final int? id;
  final int? userId;
  final String? title;
  final String? category;  
  final int? prepTime;
  final String? imageUrl;
  bool? isFavorite;
  final String? createdAt;

  Recipe({
    required this.id,
    required this.userId,
    required this.title,
    this.category,
    this.imageUrl,    
    this.isFavorite,
    this.prepTime,
    required this.createdAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        category: json['category'],
        imageUrl: json['imageUrl'] ??
            "https://upload.wikimedia.org/wikipedia/commons/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg",        
        isFavorite: json['isFavorite'] ?? false,
        prepTime: json['prepTime'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'title': title,
        'category': category,
        'imageUrl': imageUrl,        
        'isFavorite': isFavorite,
        'prepTime': prepTime,
        'created_at': createdAt,
      };
}
