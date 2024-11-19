import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/features/auth/domain/entities/request/register_request.dart';
import 'package:oshop_coderay/features/auth/presentation/controllers/auth_controller.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';
import '../../../../core/components/spaces.dart';

import '../../../../core/constants/colors.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        children: [
          const Text(
            'Register Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Hello, please complete the data below to register a new account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(50.0),
          const SpaceHeight(60.0),
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Name',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.name.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.phone.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Email ID',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.email.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: passwordController,
            textInputAction: TextInputAction.next,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.password.svg(),
              ),
            ),
          ),
          const SpaceHeight(20.0),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Assets.icons.password.svg(),
              ),
            ),
          ),
          const SpaceHeight(50.0),
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
                  if (passwordController.text ==
                          confirmPasswordController.text &&
                      passwordController.text.isNotEmpty &&
                      confirmPasswordController.text.isNotEmpty) {
                    authController.register(
                      RegisterRequest(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        phone: phoneController.text,
                      ),
                    );
                  } else if (passwordController.text.isEmpty &&
                      confirmPasswordController.text.isEmpty) {
                    passwordController.clear();
                    confirmPasswordController.clear();
                    Get.snackbar("Failed",
                        "Passwords are required. Please fill in all fields.");
                  } else {
                    passwordController.clear();
                    confirmPasswordController.clear();
                    Get.snackbar("Failed",
                        "Passwords do not match. Please ensure both password fields are identical.");
                  }
                },
                label: 'Register',
              );
            }
          }),
          const SpaceHeight(50.0),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Already Account? ',
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                  TextSpan(
                    text: 'Login Now',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
