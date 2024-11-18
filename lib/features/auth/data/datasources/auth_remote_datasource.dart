import 'package:dio/dio.dart';
import '../../../../core/constants/main_url.dart';
import '../models/request/login_request_model.dart';
import '../models/request/register_request_model.dart';
import '../models/response/auth_model.dart';
import '../models/response/message_validate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as secure_storage;

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
        await storage.write(key: 'save', value: result.accessToken);
        return result;
      } else {
        final errorResponse = MessageValidateModel.fromJson(response.data);

        throw Exception(errorResponse.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MessageValidateModel> logout() async {
    try {
      String? value = await storage.read(key: 'save');

      final response = await dio.post(
        "${MainUrl.url}/logout",
        options: Options(
          headers: {
            'Authorization': "Bearer $value",
            "Content-Type": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        await storage.delete(key: 'save');
        return MessageValidateModel.fromRawJson(response.data);
      } else {
        throw MessageValidateModel.fromRawJson(response.data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<AuthModel> register(RegisterRequestModel request) async {
    try {
      final response =
          await dio.post('${MainUrl.url}/register', data: request.toRawJson());
      if (response.statusCode == 201) {
        final AuthModel result = AuthModel.fromRawJson(response.data);
        await storage.write(key: 'save', value: result.accessToken);
        return result;
      } else {
        throw MessageValidateModel.fromRawJson(response.data);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
