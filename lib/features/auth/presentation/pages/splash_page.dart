import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text(
              "Oshop",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(30.0),
            child: Text(
              'Coderay',
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
