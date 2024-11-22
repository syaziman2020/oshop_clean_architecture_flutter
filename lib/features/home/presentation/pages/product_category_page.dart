import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/features/home/presentation/controllers/home_controller.dart';

import '../../../../core/components/search_input.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/colors.dart';
import '../widgets/product_card.dart';

class ProductCategoryPage extends StatelessWidget {
  ProductCategoryPage(
      {super.key, this.focusStatus = false, required this.category});
  final bool? focusStatus;
  final int category;

  final TextEditingController searchController = TextEditingController();

  final homeController = Get.find<HomeController>();

  void _initialize() async {
    homeController.getProductCategories(category: category);
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() => _initialize());
    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchInput(
            onChanged: (change) {
              homeController.filterProductCategories(change);
            },
            onFocus: FocusNode(),
            autoFocus: focusStatus ?? false,
            controller: searchController,
          ),
          const SpaceHeight(10.0),
          Obx(() {
            List data = (homeController.searchStatus.value ||
                    searchController.text.isNotEmpty)
                ? homeController.productListFilteredCategories
                : homeController.productListCategories;

            String errorMessage = homeController.errorProducts.value.message;
            if (homeController.loadingProducts.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpaceHeight(MediaQuery.of(context).size.height / 3),
                  const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              );
            } else if (errorMessage.isNotEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpaceHeight(MediaQuery.of(context).size.height / 3),
                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            } else if (data.isEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpaceHeight(MediaQuery.of(context).size.height / 3),
                  const Center(
                    child: Text(
                      "Data is Empty",
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            } else if (data.isNotEmpty) {
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollEndNotification &&
                      scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent) {
                    searchController.clear();
                    homeController.loadMoreProductCategories(category);
                  }
                  return false;
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: RefreshIndicator(
                    displacement: 20,
                    backgroundColor: AppColors.white,
                    color: AppColors.primary,
                    onRefresh: () async {
                      homeController.refreshProductCategories(category);
                    },
                    child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 14),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 40.0,
                          childAspectRatio: 0.89,
                        ),
                        itemCount: (homeController.searchStatus.value ||
                                searchController.text.isNotEmpty)
                            ? homeController
                                .productListFilteredCategories.length
                            : homeController.productListCategories.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            data: data[index],
                          );
                        }),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }
}
