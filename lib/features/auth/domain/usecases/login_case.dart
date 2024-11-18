import 'package:dartz/dartz.dart';
import '../entities/request/login_request.dart';
import '../entities/response/auth_response.dart';
import '../repositories/auth_repository.dart';

class LoginCase {
  final AuthRepository authRepository;
  const LoginCase(this.authRepository);

  Future<Either<MessageValidate, AuthResponse>> execute(
      LoginRequest request) async {
    return await authRepository.login(request);
  }
}
