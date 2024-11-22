import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/features/home/domain/usecases/get_product_categories.dart';
import '../../domain/entities/response/all_product_response.dart';
import '../../domain/entities/response/category_response.dart';
import '../../domain/usecases/get_categories_case.dart';
import '../../domain/usecases/get_products_case.dart';

import '../../domain/entities/response/message_validate.dart';

class HomeController extends GetxController {
  final GetCategoriesCase getCategoriesCase;
  final GetProductsCase getProductsCase;
  final GetProductCategoriesCase getProductCategoriesCase;

  HomeController({
    required this.getCategoriesCase,
    required this.getProductsCase,
    required this.getProductCategoriesCase,
  });

  @override
  void onInit() async {
    super.onInit();
    //Future.wait agar eksekusi secara paralel
    await Future.wait([
      getCategories(),
      getProducts(),
    ]);
    categoryTrigger(0);
    productListFiltered.addAll(productList);
    productListFilteredCategories.addAll(productListCategories);
  }

  RxBool loadingCategories = false.obs;

  RxBool loadingProducts = false.obs;
  RxBool loadingMoreProducts = false.obs;
  RxBool searchStatus = false.obs;

  Rx<MessageValidate> messageValidate = MessageValidate(message: "").obs;
  Rx<MessageValidate> errorProducts = MessageValidate(message: "").obs;

  RxList categories = <CategoryResponse>[].obs;

  RxInt currentPage = 0.obs;
  RxInt currentPageCategories = 0.obs;
  RxInt categoryTrigger = 0.obs;

  Rx<AllProductResponse> allProducts =
      AllProductResponse(currentPage: 1, products: [], lastPage: 1).obs;

  Rx<AllProductResponse> allProductCategories =
      AllProductResponse(currentPage: 1, products: [], lastPage: 1).obs;

  RxList productList = <ProductResponse>[].obs;
  RxList productListCategories = <ProductResponse>[].obs;
  RxList productListFiltered = <ProductResponse>[].obs;
  RxList productListFilteredCategories = <ProductResponse>[].obs;

  Future<void> getCategories() async {
    loadingCategories(true);
    try {
      Either<MessageValidate, List<CategoryResponse>> result =
          await getCategoriesCase.execute();
      result.fold((l) {
        loadingCategories(false);
        messageValidate.value = l;
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
        errorProducts.value = l;
      }, (r) {
        loadingProducts(false);
        allProducts.value = r;
        currentPage.value = r.currentPage;
        productList.assignAll(r.products);
      });
    } catch (e) {
      loadingProducts(false);
      Get.snackbar("Failed", e.toString());
    } finally {
      loadingProducts(false);
    }
  }

  Future<void> getProductCategories(
      {required int category, int page = 1}) async {
    loadingProducts(true);
    try {
      Either<MessageValidate, AllProductResponse> result =
          await getProductCategoriesCase.execute(category, page);
      result.fold((l) {
        loadingProducts(false);
        errorProducts.value = l;
      }, (r) {
        loadingProducts(false);
        allProductCategories.value = r;
        currentPageCategories.value = r.currentPage;
        productListCategories.assignAll(r.products);
      });
    } catch (e) {
      loadingProducts(false);
      Get.snackbar("Failed", e.toString());
    } finally {
      loadingProducts(false);
    }
  }

  Future<void> refreshProducts() async {
    await getProducts(page: 1);
  }

  Future<void> refreshProductCategories(int category) async {
    await getProductCategories(category: category, page: 1);
  }

  Future<void> loadMoreProducts() async {
    int nextPage = currentPage.value + 1;
    if (nextPage <= allProducts.value.lastPage) {
      loadingMoreProducts(true);

      Either<MessageValidate, AllProductResponse> result =
          await getProductsCase.execute(nextPage);
      result.fold((l) {}, (r) {
        currentPage.value = r.currentPage;
        loadingMoreProducts(false);
        searchStatus(false);
        productList.addAllIf(
            nextPage <= allProducts.value.lastPage, r.products);
      });
    }
  }

  Future<void> loadMoreProductCategories(int category) async {
    int nextPage = currentPageCategories.value + 1;
    if (nextPage <= allProductCategories.value.lastPage) {
      loadingMoreProducts(true);

      Either<MessageValidate, AllProductResponse> result =
          await getProductCategoriesCase.execute(category, nextPage);
      result.fold((l) {}, (r) {
        currentPageCategories.value = r.currentPage;
        loadingMoreProducts(false);
        searchStatus(false);
        productListCategories.addAllIf(
            nextPage <= allProductCategories.value.lastPage, r.products);
      });
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      productListFiltered.value = productList;
    } else {
      searchStatus(true);
      productListFiltered.value = productList
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void filterProductCategories(String query) {
    if (query.isEmpty) {
      productListFilteredCategories.value = productListCategories;
    } else {
      searchStatus(true);
      productListFilteredCategories.value = productListCategories
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
