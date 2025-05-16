class Ingredient {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;

  Ingredient({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'created_at': createdAt.toIso8601String(),
      };
}
