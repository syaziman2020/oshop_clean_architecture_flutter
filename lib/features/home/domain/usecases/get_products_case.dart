import 'package:dartz/dartz.dart';
import '../entities/response/all_product_response.dart';
import '../entities/response/message_validate.dart';
import '../repositories/home_repository.dart';

class GetProductsCase {
  final HomeRepository homeRepository;
  GetProductsCase(this.homeRepository);

  Future<Either<MessageValidate, AllProductResponse>> execute(int page) async {
    return await homeRepository.getProducts(page);
  }
}
