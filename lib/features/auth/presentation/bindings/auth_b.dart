import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../domain/usecases/logout_case.dart';
import '../../domain/usecases/register_case.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_implementation.dart';
import '../../domain/usecases/login_case.dart';
import '../controllers/auth_controller.dart';

class AuthB extends Bindings {
  @override
  void dependencies() {
    // 1. Core dependencies
    final Dio dio = Dio();
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();

    // 2. Data Source
    Get.put<AuthRemoteDatasource>(
      AuthRemoteDataSourceImplementation(
        dio: dio,
        storage: secureStorage,
      ),
    );

    Get.put<AuthController>(
      AuthController(
        loginCase: LoginCase(
          AuthRepositoryImplementation(
            authRemoteDatasource: Get.find<AuthRemoteDatasource>(),
          ),
        ),
        registerCase: RegisterCase(
          AuthRepositoryImplementation(
            authRemoteDatasource: Get.find<AuthRemoteDatasource>(),
          ),
        ),
        logoutCase: LogoutCase(
          AuthRepositoryImplementation(
            authRemoteDatasource: Get.find<AuthRemoteDatasource>(),
          ),
        ),
      ),
    );
  }
}
