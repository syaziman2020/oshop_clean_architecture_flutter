import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../../../core/data/datasource/auth_local_datasource.dart';

import '../navigation/auth_routes.dart';
import '../../../home/presentation/navigation/home_routes.dart';

class SplashController extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1)).then((_) async {
      bool status = await AuthLocalDatasourceImplementation(storage).isAuth();
      if (status) {
        Get.offNamed(HomeRoutes.dashboard);
      } else {
        Get.offNamed(AuthRoutes.login);
      }
    });
    super.onInit();
  }
}
