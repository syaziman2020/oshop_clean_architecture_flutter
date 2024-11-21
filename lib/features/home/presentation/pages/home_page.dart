import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/core/constants/colors.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/category_response.dart';
import 'package:oshop_coderay/features/home/presentation/pages/see_all_page.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/search_input.dart';
import '../../../../core/components/spaces.dart';

import '../../domain/entities/response/all_product_response.dart';
import '../controllers/home_controller.dart';
import '../widgets/banner_slider.dart';
import '../widgets/organisim/menu_categories.dart';
import '../widgets/organisim/product_list.dart';

import '../widgets/title_content.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.onTabChange, this.onSearchChange});

  final TextEditingController searchController = TextEditingController();

  final homeController = Get.find<HomeController>();
  final Function(int tab) onTabChange;
  Function(bool change)? onSearchChange;

  final List<String> banners1 = [
    Assets.images.banner1.path,
    Assets.images.banner1.path,
    Assets.images.banner1.path,
  ];
  final List<String> banners2 = [
    Assets.images.banner2.path,
    Assets.images.banner2.path,
    Assets.images.banner2.path,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchInput(
            controller: searchController,
            onTap: () {
              onTabChange(1);
              if (onSearchChange != null) {
                onSearchChange!(true);
              }
            },
          ),
          const SpaceHeight(16.0),
          BannerSlider(items: banners1),
          const SpaceHeight(12.0),
          TitleContent(
            title: 'Categories',
            onSeeAllTap: () {
              Get.to(
                () => SeeAllPage(
                  titleHeader: "All Categories",
                  widget: MenuCategories(),
                ),
              );
            },
          ),
          const SpaceHeight(12.0),
          MenuCategories(
            categoryCount: 4,
          ),
          Obx(() {
            String errorMessage = homeController.errorProducts.value.message;

            if (homeController.loadingProducts.value) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpaceHeight(50),
                  Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              );
            } else if (errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            } else if (errorMessage.isEmpty) {
              return ProductList(
                title: 'Featured Product',
                onSeeAllTap: () {},
                items: (homeController.productList as List<ProductResponse>)
                    .take(2)
                    .toList(),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          const SpaceHeight(50.0),
          BannerSlider(items: banners2),
          const SpaceHeight(28.0),
          Obx(() {
            if (homeController.loadingProducts.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else if (!homeController.loadingCategories.value &&
                !homeController.loadingProducts.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...(homeController.categories as List<CategoryResponse>)
                      .take(3)
                      .map((e) {
                    final filteredProducts =
                        (homeController.productList as List<ProductResponse>)
                            .where((product) {
                              return product.categoryId ==
                                  e.id; // Kondisi where
                            })
                            .take(2)
                            .toList();
                    return ProductList(
                      title: e.name,
                      onSeeAllTap: () {},
                      items: filteredProducts,
                    );
                  }),
                ],
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
