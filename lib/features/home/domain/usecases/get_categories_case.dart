import 'package:dartz/dartz.dart';

import '../entities/response/category_response.dart';
import '../entities/response/message_validate.dart';
import '../repositories/home_repository.dart';

class GetCategoriesCase {
  final HomeRepository homeRepository;
  GetCategoriesCase(this.homeRepository);

  Future<Either<MessageValidate, List<CategoryResponse>>> execute() async {
    return await homeRepository.getCategories();
  }
}
