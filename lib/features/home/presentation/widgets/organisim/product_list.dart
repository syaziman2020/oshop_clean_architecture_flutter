import 'package:flutter/material.dart';
import 'package:oshop_coderay/features/home/domain/entities/response/all_product_response.dart';

import '../../../../../core/components/spaces.dart';
import '../product_card.dart';
import '../title_content.dart';

class ProductList extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllTap;
  final List<ProductResponse> items;

  const ProductList({
    super.key,
    required this.title,
    required this.onSeeAllTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceHeight(30),
        TitleContent(
          title: title,
          onSeeAllTap: onSeeAllTap,
        ),
        const SpaceHeight(20.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 55.0,
              childAspectRatio: 0.89),
          itemCount: items.length,
          itemBuilder: (context, index) => ProductCard(
            data: items[index],
          ),
        )
      ],
    );
  }
}
