import 'package:dartz/dartz.dart';

import '../entities/response/all_product_response.dart';
import '../entities/response/category_response.dart';
import '../entities/response/message_validate.dart';

abstract class HomeRepository {
  Future<Either<MessageValidate, List<CategoryResponse>>> getCategories();
  Future<Either<MessageValidate, AllProductResponse>> getProducts(int page);
  Future<Either<MessageValidate, AllProductResponse>> getProductCategories(
      int category, int page);
}
