import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/core/constants/colors.dart';
import 'package:oshop_coderay/features/home/presentation/controllers/home_controller.dart';

import '../../../domain/entities/response/category_response.dart';
import '../category_button.dart';

class MenuCategories extends StatelessWidget {
  MenuCategories({
    super.key,
    this.categoryCount,
    required this.onTapCategory,
  });
  final int? categoryCount;
  final Function onTapCategory;

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String message = homeController.messageValidate.value.message;
      if (homeController.loadingCategories.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        );
      } else if (message.isNotEmpty) {
        return Center(
          child: Text(
            message,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else if (homeController.categories.isNotEmpty) {
        return Wrap(
          children: List.generate(
            (homeController.categories.length / 4).ceil(),
            (index) {
              List<CategoryResponse> categoryRow =
                  (homeController.categories as List<CategoryResponse>)
                      .take(categoryCount ?? homeController.categories.length)
                      .skip(index * 4)
                      .take(4)
                      .toList();

              return Row(
                children: categoryRow.map((e) {
                  return Flexible(
                    child: CategoryButton(
                      imagePath: e.imageUrl,
                      label: e.name,
                      onPressed: () {
                        homeController.categoryTrigger.value = e.id;
                        onTapCategory();
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
