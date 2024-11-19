import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/request/login_request.dart';
import '../../../../core/assets/assets.gen.dart';
import '../../../../core/components/buttons.dart';

import '../../../../core/components/spaces.dart';
import '../../../../core/constants/colors.dart';
import '../controllers/auth_controller.dart';
import '../navigation/auth_routes.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        children: [
          const Text(
            'Login Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Hello, welcome back to our account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SpaceHeight(50.0),
          const SpaceHeight(60.0),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
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
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
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
                  authController.login(
                    LoginRequest(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },
                label: 'Login',
              );
            }
          }),
          const SpaceHeight(50.0),
          InkWell(
            onTap: () {
              Get.toNamed(AuthRoutes.register);
            },
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Not Registered yet? ',
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                  TextSpan(
                    text: 'Create an Account',
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
