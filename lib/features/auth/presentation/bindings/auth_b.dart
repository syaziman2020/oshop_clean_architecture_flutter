import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_implementation.dart';
import '../../domain/usecases/login_case.dart';
import '../controllers/auth_controller.dart';

class AuthB extends Bindings {
  @override
  void dependencies() {
    final Dio dio = Dio();
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final AuthRemoteDataSourceImplementation
        authRemoteDataSourceImplementation = AuthRemoteDataSourceImplementation(
      dio: dio,
      storage: secureStorage,
    );

    Get.put(
      AuthController(
        loginCase: LoginCase(
          AuthRepositoryImplementation(
              authRemoteDatasource: authRemoteDataSourceImplementation),
        ),
      ),
    );
  }
}
