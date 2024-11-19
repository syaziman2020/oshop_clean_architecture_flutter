import 'package:dartz/dartz.dart';
import 'package:oshop_coderay/features/home/data/datasources/home_remote_datasource.dart';
import 'package:oshop_coderay/features/home/data/models/category_model.dart';
import 'package:oshop_coderay/features/home/data/models/product_model.dart';

import 'package:oshop_coderay/features/home/domain/entities/response/all_product_response.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/category_response.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/message_validate.dart';
import 'package:oshop_coderay/features/home/domain/repositories/home_repository.dart';

import '../models/message_validate_model.dart';

class HomeRepositoryImplementation extends HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;
  HomeRepositoryImplementation({required this.homeRemoteDatasource});
  @override
  Future<Either<MessageValidate, List<CategoryResponse>>>
      getCategories() async {
    try {
      final List<CategoryModel> categories =
          await homeRemoteDatasource.getCategories();
      return Right(categories);
    } catch (e) {
      if (e is MessageValidateModel) {
        return Left(
          MessageValidateModel(
            message: e.message,
          ),
        );
      } else {
        return Left(
          MessageValidateModel(
            message: e.toString().contains('Exception:')
                ? e.toString().split('Exception:')[1].trim()
                : e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<MessageValidate, AllProductResponse>> getProducts(
      int page) async {
    try {
      final ProductModel products =
          await homeRemoteDatasource.getProducts(page);
      return Right(products);
    } catch (e) {
      if (e is MessageValidateModel) {
        return Left(
          MessageValidateModel(
            message: e.message,
          ),
        );
      } else {
        return Left(
          MessageValidateModel(
            message: e.toString().contains('Exception:')
                ? e.toString().split('Exception:')[1].trim()
                : e.toString(),
          ),
        );
      }
    }
  }
}
