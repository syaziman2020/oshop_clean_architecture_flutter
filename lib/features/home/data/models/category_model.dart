import '../../domain/entities/response/category_response.dart';

class CategoryModel extends CategoryResponse {
  final String image;

  CategoryModel({
    required super.id,
    required super.name,
    super.description,
    required this.image,
    required super.createdAt,
    required super.updatedAt,
  }) : super(imageUrl: image);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  static List<CategoryModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
