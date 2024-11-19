import 'package:dartz/dartz.dart';

import 'package:oshop_coderay/features/home/domain/entities/response/all_product_response.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/category_response.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/message_validate.dart';

abstract class HomeRepository {
  Future<Either<MessageValidate, List<CategoryResponse>>> getCategories();
  Future<Either<MessageValidate, AllProductResponse>> getProducts(int page);
}
