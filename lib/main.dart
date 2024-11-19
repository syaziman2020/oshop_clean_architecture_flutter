import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/navigation/app_pages.dart';
import 'core/constants/colors.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
      ),
      getPages: AppPages.pages,
    );
  }
}
