import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  VerifyOtpUseCase(this._repository);
  final AuthRepository _repository;

  Future<UserEntity> call({required String phone, required String otp}) =>
      _repository.verifyOtp(phone: phone, otp: otp);
}
