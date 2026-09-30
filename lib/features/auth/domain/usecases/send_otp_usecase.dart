import '../repositories/auth_repository.dart';

class SendOtpUseCase {
  SendOtpUseCase(this._repository);
  final AuthRepository _repository;

  Future<void> call({required String phone}) =>
      _repository.sendOtp(phone: phone);
}
