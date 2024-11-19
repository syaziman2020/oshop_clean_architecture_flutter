class CategoryResponse {
  final int id;
  final String name;
  final String? description;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryResponse({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
}
