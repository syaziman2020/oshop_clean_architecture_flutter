import 'package:dartz/dartz.dart';
import '../entities/request/login_request.dart';
import '../entities/request/register_request.dart';
import '../entities/response/auth_response.dart';

abstract class AuthRepository {
  Future<Either<MessageValidate, AuthResponse>> login(LoginRequest request);
  Future<Either<MessageValidate, MessageValidate>> logout();
  Future<Either<MessageValidate, AuthResponse>> register(
      RegisterRequest request);
}
