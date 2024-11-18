import 'package:dartz/dartz.dart';
import '../entities/request/register_request.dart';
import '../entities/response/auth_response.dart';
import '../repositories/auth_repository.dart';

class RegisterCase {
  final AuthRepository authRepository;

  RegisterCase(this.authRepository);

  Future<Either<MessageValidate, AuthResponse>> execute(
      RegisterRequest request) async {
    return await authRepository.register(request);
  }
}
