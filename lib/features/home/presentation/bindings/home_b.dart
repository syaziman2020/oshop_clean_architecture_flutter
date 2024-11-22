import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_implementation.dart';
import '../../domain/usecases/get_categories_case.dart';
import '../../domain/usecases/get_product_categories.dart';
import '../../domain/usecases/get_products_case.dart';
import '../controllers/home_controller.dart';

class HomeB extends Bindings {
  @override
  void dependencies() {
    // 1. Core dependencies
    final Dio dio = Dio();
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    // 2. Data Source
    Get.put<HomeRemoteDatasource>(
      HomeRemoteDatasourceImplementation(
        dio: dio,
        storage: secureStorage,
      ),
    );

    Get.put<HomeController>(
      HomeController(
        getCategoriesCase: GetCategoriesCase(
          HomeRepositoryImplementation(
            homeRemoteDatasource: Get.find<HomeRemoteDatasource>(),
          ),
        ),
        getProductsCase: GetProductsCase(
          HomeRepositoryImplementation(
            homeRemoteDatasource: Get.find<HomeRemoteDatasource>(),
          ),
        ),
        getProductCategoriesCase: GetProductCategoriesCase(
          HomeRepositoryImplementation(
            homeRemoteDatasource: Get.find<HomeRemoteDatasource>(),
          ),
        ),
      ),
    );
  }
}
