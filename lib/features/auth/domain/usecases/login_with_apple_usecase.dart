import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithAppleUseCase {
  LoginWithAppleUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserEntity> call() => _repository.loginWithApple();
}
