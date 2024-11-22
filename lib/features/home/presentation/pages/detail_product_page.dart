import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oshop_coderay/core/components/components.dart';
import 'package:oshop_coderay/core/extensions/int_ext.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/all_product_response.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/constants/colors.dart';

class DetailProductPage extends StatelessWidget {
  const DetailProductPage({
    super.key,
    required this.productResponse,
  });
  final ProductResponse productResponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detail Product',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1), // Ketebalan garis
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05), blurRadius: 3)
                ]), // Warna garis
            height: 1, // Tinggi garis
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icons.cart.svg(height: 22.0),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        double size = constraints.maxWidth - 25;
        return ListView(padding: const EdgeInsets.all(25), children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              width: size,
              height: size,
              productResponse.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SpaceHeight(30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productResponse.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primary,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    child: Center(
                      child: Text(
                        "Tersedia ${productResponse.isAvailable}",
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SpaceHeight(10),
              Text(
                productResponse.price.currencyFormatRp,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SpaceHeight(25),
              const Divider(
                color: AppColors.bgLogin,
              ),
              const SpaceHeight(25),
              const Text(
                "Description",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SpaceHeight(10),
              Text(
                (productResponse.description != null)
                    ? productResponse.description!
                    : "-",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SpaceHeight(15),
              const Divider(
                color: AppColors.bgLogin,
              ),
              const SpaceHeight(15),
              Row(
                children: [
                  Flexible(
                    child: Button.outlined(
                      onPressed: () {},
                      label: 'Add Cart',
                    ),
                  ),
                  const SpaceWidth(20),
                  Flexible(
                    child: Button.filled(
                      onPressed: () {},
                      label: 'Checkout Now',
                    ),
                  ),
                ],
              )
            ],
          ),
        ]);
      }),
    );
  }
}
