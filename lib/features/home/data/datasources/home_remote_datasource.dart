import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secure_storage;
import 'package:oshop_coderay/core/constants/main_url.dart';
import 'package:oshop_coderay/features/home/data/models/category_model.dart';
import 'package:oshop_coderay/features/home/data/models/message_validate_model.dart';
import 'package:oshop_coderay/features/home/data/models/product_model.dart';

import '../../../../core/data/datasource/auth_local_datasource.dart';

abstract class HomeRemoteDatasource {
  Future<List<CategoryModel>> getCategories();
  Future<ProductModel> getProducts(int page);
  Future<ProductModel> getProductCategories(int category, int page);
}

class HomeRemoteDatasourceImplementation extends HomeRemoteDatasource {
  final Dio dio;
  final secure_storage.FlutterSecureStorage storage;
  HomeRemoteDatasourceImplementation(
      {required this.dio, required this.storage});
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final authData =
          await AuthLocalDatasourceImplementation(storage).getAuthData();
      final response = await dio.get(
        "${MainUrl.url}/categories",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${authData?.token}'
          },
        ),
      );

      if (response.statusCode == 200) {
        return CategoryModel.fromJsonList(response.data["data"]);
      } else {
        throw MessageValidateModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProducts(int page) async {
    try {
      final authData =
          await AuthLocalDatasourceImplementation(storage).getAuthData();
      final response = await dio.get(
        "${MainUrl.url}/products?page=$page",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${authData?.token}'
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data["data"]);
      } else {
        throw MessageValidateModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductCategories(int category, int page) async {
    try {
      final authData =
          await AuthLocalDatasourceImplementation(storage).getAuthData();
      final response = await dio.get(
        "${MainUrl.url}/products?category_id=$category&page=$page",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${authData?.token}'
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data["data"]);
      } else {
        throw MessageValidateModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
