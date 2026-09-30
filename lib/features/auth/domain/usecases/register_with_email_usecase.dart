import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterWithEmailUseCase {
  RegisterWithEmailUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserEntity> call({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) => _repository.registerWithEmail(
    name: name,
    email: email,
    phone: phone,
    password: password,
  );
}
