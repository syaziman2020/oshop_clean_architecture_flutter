import 'package:dartz/dartz.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/all_product_response.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/message_validate.dart';
import 'package:oshop_coderay/features/home/domain/repositories/home_repository.dart';

class GetProductsCase {
  final HomeRepository homeRepository;
  GetProductsCase(this.homeRepository);

  Future<Either<MessageValidate, AllProductResponse>> execute(int page) async {
    return await homeRepository.getProducts(page);
  }
}
