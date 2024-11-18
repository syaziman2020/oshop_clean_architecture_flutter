import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:oshop_coderay/features/home/presentation/pages/dashboard_page.dart';
import '../../domain/entities/request/login_request.dart';
import '../../domain/entities/response/auth_response.dart';

import '../../domain/usecases/login_case.dart';
import '../navigation/auth_routes.dart';

class AuthController extends GetxController {
  final LoginCase loginCase;

  AuthController({required this.loginCase});
  RxBool isLogin = false.obs;

  Future<void> login(LoginRequest request) async {
    isLogin(true);
    try {
      Either<MessageValidate, AuthResponse> result =
          await loginCase.execute(request);
      result.fold((l) {
        isLogin(false);
        Get.snackbar("Error", l.message);
      }, (r) {
        isLogin(false);
        Get.offNamed("/dashboard");
      });
    } catch (e) {
      isLogin(false);
      Get.snackbar("Error", e.toString());
    } finally {
      isLogin(false);
    }
  }
}
