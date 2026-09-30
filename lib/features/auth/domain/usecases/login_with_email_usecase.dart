import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmailUseCase {
  LoginWithEmailUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserEntity> call({required String email, required String password}) =>
      _repository.loginWithEmail(email: email, password: password);
}
