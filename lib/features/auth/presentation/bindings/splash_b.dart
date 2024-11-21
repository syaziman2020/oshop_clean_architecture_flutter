import 'package:get/get.dart';
import 'package:oshop_coderay/features/auth/presentation/controllers/splash_controller.dart';

class SplashB extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
