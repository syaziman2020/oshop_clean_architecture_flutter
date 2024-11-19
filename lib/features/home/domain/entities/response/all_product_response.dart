class AllProductResponse {
  final int currentPage;
  final List<ProductResponse> products;
  final int lastPage;
  AllProductResponse({
    required this.currentPage,
    required this.products,
    required this.lastPage,
  });
}

class ProductResponse {
  final int id;
  final int categoryId;
  final String name;
  final int price;
  final int stock;
  final String imageUrl;
  final String? description;
  final int isAvailable;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductResponse({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
    this.description,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });
}
