import 'package:dartz/dartz.dart';
import '../entities/response/auth_response.dart';
import '../repositories/auth_repository.dart';

class LogoutCase {
  final AuthRepository authRepository;
  LogoutCase(this.authRepository);

  Future<Either<MessageValidate, MessageValidate>> execute() async {
    return await authRepository.logout();
  }
}
