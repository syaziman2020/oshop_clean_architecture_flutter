import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../domain/entities/request/register_request.dart';
import '../../domain/usecases/logout_case.dart';
import '../../domain/usecases/register_case.dart';
import '../../../home/presentation/pages/dashboard_page.dart';
import '../../domain/entities/request/login_request.dart';
import '../../domain/entities/response/auth_response.dart';

import '../../domain/usecases/login_case.dart';
import '../navigation/auth_routes.dart';

class AuthController extends GetxController {
  final LoginCase loginCase;
  final RegisterCase registerCase;
  final LogoutCase logoutCase;

  AuthController({
    required this.loginCase,
    required this.registerCase,
    required this.logoutCase,
  });
  RxBool isLogin = false.obs;

  Future<void> login(LoginRequest request) async {
    isLogin(true);
    try {
      Either<MessageValidate, AuthResponse> result =
          await loginCase.execute(request);
      result.fold((l) {
        isLogin(false);
        Get.snackbar("Failed", l.message);
      }, (r) {
        isLogin(false);
        Get.offNamed("/dashboard");
      });
    } catch (e) {
      isLogin(false);
      Get.snackbar("Failed", e.toString());
    } finally {
      isLogin(false);
    }
  }

  Future<void> register(RegisterRequest request) async {
    isLogin(true);
    try {
      Either<MessageValidate, AuthResponse> result =
          await registerCase.execute(request);
      result.fold((l) {
        isLogin(false);
        Get.snackbar("Failed", l.message);
      }, (r) {
        isLogin(false);
        Get.offNamed("/dashboard");
      });
    } catch (e) {
      isLogin(false);
      Get.snackbar("Failed", e.toString());
    } finally {
      isLogin(false);
    }
  }

  Future<void> logout() async {
    isLogin(true);
    try {
      Either<MessageValidate, MessageValidate> result =
          await logoutCase.execute();

      result.fold((l) {
        isLogin(false);
        Get.snackbar("Failed", l.toString());
      }, (r) {
        isLogin(false);
        Get.snackbar("Success", r.message);
        Get.offNamed(AuthRoutes.login);
      });
    } catch (e) {
      isLogin(false);
      Get.snackbar("Failed", e.toString());
    } finally {
      isLogin(false);
    }
  }
}
