import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/features/home/data/models/product_model.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/all_product_response.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/category_response.dart';
import 'package:oshop_coderay/features/home/domain/usecases/get_categories_case.dart';
import 'package:oshop_coderay/features/home/domain/usecases/get_products_case.dart';

import '../../domain/entities/response/message_validate.dart';

class HomeController extends GetxController {
  final GetCategoriesCase getCategoriesCase;
  final GetProductsCase getProductsCase;

  HomeController(
      {required this.getCategoriesCase, required this.getProductsCase});

  @override
  void onInit() async {
    super.onInit();
    //Future.wait agar eksekusi secara paralel
    await Future.wait([
      getCategories(),
      getProducts(),
    ]);
  }

  RxBool loadingCategories = false.obs;

  RxBool loadingProducts = false.obs;

  RxList categories = <CategoryResponse>[].obs;

  Rx<AllProductResponse> allProducts =
      AllProductResponse(currentPage: 1, products: [], lastPage: 1).obs;

  Future<void> getCategories() async {
    loadingCategories(true);
    try {
      Either<MessageValidate, List<CategoryResponse>> result =
          await getCategoriesCase.execute();
      result.fold((l) {
        loadingCategories(false);
        Get.snackbar("Failed", l.message);
      }, (r) {
        loadingCategories(false);
        categories.assignAll(r);
      });
    } catch (e) {
      loadingCategories(false);
      Get.snackbar("Failed", e.toString());
    } finally {
      loadingCategories(false);
    }
  }

  Future<void> getProducts({int page = 1}) async {
    loadingProducts(true);
    try {
      Either<MessageValidate, AllProductResponse> result =
          await getProductsCase.execute(page);
      result.fold((l) {
        loadingProducts(false);
        Get.snackbar("Failed", l.message);
      }, (r) {
        loadingProducts(false);
        allProducts.value = r;
      });
    } catch (e) {
      loadingProducts(false);
      Get.snackbar("Failed", e.toString());
    } finally {
      loadingProducts(false);
    }
  }
}
