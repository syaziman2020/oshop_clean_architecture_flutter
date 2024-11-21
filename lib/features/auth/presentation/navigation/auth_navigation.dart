import 'package:get/get.dart';
import 'package:oshop_coderay/features/auth/presentation/bindings/splash_b.dart';
import 'package:oshop_coderay/features/auth/presentation/pages/splash_page.dart';
import '../bindings/auth_b.dart';
import 'auth_routes.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class AuthNavigation {
  static final routes = [
    GetPage(
      name: AuthRoutes.splash,
      page: () => SplashPage(),
      binding: SplashB(),
    ),
    GetPage(
      name: AuthRoutes.login,
      page: () => LoginPage(),
      bindings: [
        AuthB(),
      ],
    ),
    GetPage(
      name: AuthRoutes.register,
      page: () => RegisterPage(),
      bindings: [
        AuthB(),
      ],
    ),
  ];
}
