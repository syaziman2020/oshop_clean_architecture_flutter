import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secure_storage;
import 'package:oshop_coderay/core/data/datasource/auth_local_datasource.dart';

import '../../../../core/constants/main_url.dart';
import '../models/request/login_request_model.dart';
import '../models/request/register_request_model.dart';
import '../models/response/auth_model.dart';
import '../models/response/message_validate.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> login(LoginRequestModel request);
  Future<AuthModel> register(RegisterRequestModel request);
  Future<MessageValidateModel> logout();
}

class AuthRemoteDataSourceImplementation extends AuthRemoteDatasource {
  final Dio dio;
  final secure_storage.FlutterSecureStorage storage;
  AuthRemoteDataSourceImplementation(
      {required this.dio, required this.storage});

  @override
  Future<AuthModel> login(LoginRequestModel request) async {
    try {
      final response = await dio.post(
        "${MainUrl.url}/login",
        data: request.toJson(),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final AuthModel result = AuthModel.fromJson(response.data);
        AuthLocalDatasourceImplementation(storage).saveAuthData(result);
        return result;
      } else {
        throw MessageValidateModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageValidateModel> logout() async {
    try {
      final authData =
          await AuthLocalDatasourceImplementation(storage).getAuthData();
      print(authData?.token);

      final response = await dio.post(
        "${MainUrl.url}/logout",
        options: Options(
          headers: {
            'Authorization': "Bearer ${authData?.token}",
            "Content-Type": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        AuthLocalDatasourceImplementation(storage).removeAuthData();
        return MessageValidateModel.fromJson(response.data);
      } else {
        throw MessageValidateModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthModel> register(RegisterRequestModel request) async {
    try {
      final response = await dio.post('${MainUrl.url}/register',
          data: request.toJson(),
          options: Options(
            headers: {
              'Accept': 'application/json',
              "Content-Type": "application/json"
            },
            validateStatus: (status) => status != null && status < 500,
          ));
      if (response.statusCode == 201) {
        final AuthModel result = AuthModel.fromRawJson(response.data);
        AuthLocalDatasourceImplementation(storage).saveAuthData(result);
        return result;
      } else {
        throw MessageValidateModel.fromJson(response.data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
