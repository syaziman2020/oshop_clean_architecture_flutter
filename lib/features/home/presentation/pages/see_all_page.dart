import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class SeeAllPage extends StatelessWidget {
  const SeeAllPage({
    super.key,
    required this.titleHeader,
    required this.widget,
  });

  final String titleHeader;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleHeader,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
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
      ),
      body: widget,
    );
  }
}
