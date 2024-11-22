import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/core/extensions/int_ext.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/all_product_response.dart';
import 'package:oshop_coderay/features/home/presentation/navigation/home_routes.dart';
import 'package:oshop_coderay/features/home/presentation/pages/detail_product_page.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/spaces.dart';
import '../../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final ProductResponse data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailProductPage(
              productResponse: data,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xffFAFAFA),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.05),
              blurRadius: 3.0,
              spreadRadius: 0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                data.imageUrl.contains('http')
                    ? data.imageUrl
                    : '${data.imageUrl}',
                width: 170.0,
                height: 112.0,
                fit: BoxFit.cover,
              ),
            ),
            const SpaceHeight(14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.name,
                        overflow: TextOverflow.visible,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        data.price.currencyFormatRp,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // context.read<CheckoutBloc>().add(CheckoutEvent.addItem(data));
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          blurRadius: 10.0,
                          offset: const Offset(0, 2),
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: Assets.icons.order.svg(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
