import '../../domain/entities/response/all_product_response.dart';

class ProductModel extends AllProductResponse {
  final List<Product> data;

  ProductModel({
    required super.currentPage,
    required this.data,
    required super.lastPage,
  }) : super(products: data);

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        currentPage: json["current_page"],
        data: List<Product>.from(
          json["data"].map(
            (x) => Product.fromJson(x),
          ),
        ),
        lastPage: json["last_page"],
      );
}

class Product extends ProductResponse {
  final String image;

  Product({
    required super.id,
    required super.categoryId,
    required super.name,
    super.description,
    required this.image,
    required super.price,
    required super.stock,
    required super.isAvailable,
    required super.createdAt,
    required super.updatedAt,
  }) : super(imageUrl: image);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        isAvailable: json["is_available"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
