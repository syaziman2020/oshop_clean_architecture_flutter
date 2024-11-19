import 'package:dartz/dartz.dart';

import 'package:oshop_coderay/features/home/domain/entities/response/category_response.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/message_validate.dart';
import 'package:oshop_coderay/features/home/domain/repositories/home_repository.dart';

class GetCategoriesCase {
  final HomeRepository homeRepository;
  GetCategoriesCase(this.homeRepository);

  Future<Either<MessageValidate, List<CategoryResponse>>> execute() async {
    return await homeRepository.getCategories();
  }
}
