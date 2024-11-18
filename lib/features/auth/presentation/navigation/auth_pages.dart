import 'package:get/get.dart';
import '../bindings/auth_b.dart';
import 'auth_routes.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class AuthPages {
  static final routes = [
    GetPage(
      name: AuthRoutes.login,
      page: () => LoginPage(),
      bindings: [
        AuthB(),
      ],
    ),
    // GetPage(
    //   name: AuthRoutes.register,
    //   page: () => RegisterPage(),
    //   bindings: [
    //     AuthB(),
    //   ],
    // ),
  ];
}
