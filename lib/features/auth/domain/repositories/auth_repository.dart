import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  });

  Future<void> sendOtp({required String phone});

  Future<UserEntity> verifyOtp({required String phone, required String otp});

  Future<UserEntity> registerWithEmail({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<UserEntity> loginWithGoogle();

  Future<UserEntity> loginWithApple();
}
