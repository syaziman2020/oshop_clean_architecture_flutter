import 'package:dartz/dartz.dart';
import '../entities/response/all_product_response.dart';
import '../entities/response/message_validate.dart';
import '../repositories/home_repository.dart';

class GetProductCategoriesCase {
  final HomeRepository homeRepository;
  GetProductCategoriesCase(this.homeRepository);

  Future<Either<MessageValidate, AllProductResponse>> execute(
      int category, int page) async {
    return await homeRepository.getProductCategories(category, page);
  }
}
