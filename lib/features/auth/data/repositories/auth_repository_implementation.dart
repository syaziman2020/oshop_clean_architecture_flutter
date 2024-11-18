import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/request/register_request_model.dart';
import '../models/response/auth_model.dart';
import '../models/response/message_validate.dart';
import '../../domain/entities/request/login_request.dart';
import '../../domain/entities/request/register_request.dart';
import '../../domain/entities/response/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/request/login_request_model.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImplementation({required this.authRemoteDatasource});
  @override
  Future<Either<MessageValidate, AuthResponse>> login(
      LoginRequest request) async {
    try {
      final LoginRequestModel requestModel = LoginRequestModel(
        email: request.email,
        password: request.password,
      );

      final AuthModel authModel =
          await authRemoteDatasource.login(requestModel);

      return Right(authModel);
    } catch (e) {
      return Left(
        MessageValidateModel(
          message: e.toString().contains('Exception:')
              ? e.toString().split('Exception:')[1].trim()
              : e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<MessageValidate, MessageValidate>> logout() async {
    try {
      final MessageValidateModel messageValidateModel =
          await authRemoteDatasource.logout();

      return Right(messageValidateModel);
    } catch (e) {
      if (e is MessageValidate) {
        return Left(MessageValidateModel(message: e.message));
      }
      return Left(MessageValidateModel(message: e.toString()));
    }
  }

  @override
  Future<Either<MessageValidate, AuthResponse>> register(
      RegisterRequest request) async {
    try {
      final RegisterRequestModel requestModel = RegisterRequestModel(
        email: request.email,
        password: request.password,
        name: request.name,
        roles: request.roles,
        phone: request.phone,
      );
      final AuthModel authModel =
          await authRemoteDatasource.register(requestModel);

      return Right(authModel);
    } catch (e) {
      if (e is MessageValidate) {
        return Left(MessageValidateModel(message: e.message));
      }
      return Left(MessageValidateModel(message: e.toString()));
    }
  }
}
