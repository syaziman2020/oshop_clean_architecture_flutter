import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/components/buttons.dart';
import '../../../../core/constants/colors.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'INI DASHBOARD',
              style: TextStyle(fontSize: 24),
            ),
            Obx(() {
              if (authController.isLogin.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              } else {
                return Button.filled(
                  onPressed: () {
                    authController.logout();
                  },
                  label: 'Logout',
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
