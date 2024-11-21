import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../features/auth/data/models/response/auth_model.dart';
import '../../../features/auth/domain/entities/response/auth_response.dart';

abstract class AuthLocalDatasource {
  Future<void> saveAuthData(AuthModel authModel);
  Future<void> removeAuthData();
  Future<AuthResponse?> getAuthData();
  Future<bool> isAuth();
}

class AuthLocalDatasourceImplementation implements AuthLocalDatasource {
  final FlutterSecureStorage storage;

  AuthLocalDatasourceImplementation(this.storage);

  @override
  Future<void> saveAuthData(AuthModel authModel) async {
    await storage.write(key: 'save', value: authModel.toRawJson());
  }

  @override
  Future<void> removeAuthData() async {
    await storage.delete(key: 'save');
  }

  @override
  Future<AuthResponse?> getAuthData() async {
    final authData = await storage.read(key: 'save');
    if (authData != null) {
      return AuthModel.fromRawJson(authData);
    }
    return null;
  }

  @override
  Future<bool> isAuth() async {
    return await storage.containsKey(key: "save");
  }
}
