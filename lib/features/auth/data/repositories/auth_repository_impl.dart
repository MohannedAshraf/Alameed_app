 import '../../../../core/constants/storage_keys.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._localStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final LocalStorageService _localStorage;

  Future<UserEntity> _persistAndReturn(AuthResponseModel response) async {
    await _localStorage.setString(StorageKeys.authToken, response.token);
    DioClient().setAuthToken(response.token);
    return response.user;
  }

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _remoteDataSource.loginWithEmail(
      email: email,
      password: password,
    );
    return _persistAndReturn(response);
  }

  @override
  Future<void> sendOtp({required String phone}) =>
      _remoteDataSource.sendOtp(phone: phone);

  @override
  Future<UserEntity> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await _remoteDataSource.verifyOtp(phone: phone, otp: otp);
    return _persistAndReturn(response);
  }

  @override
  Future<UserEntity> registerWithEmail({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await _remoteDataSource.registerWithEmail(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
    return _persistAndReturn(response);
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    final response = await _remoteDataSource.loginWithGoogle();
    return _persistAndReturn(response);
  }

  @override
  Future<UserEntity> loginWithApple() async {
    final response = await _remoteDataSource.loginWithApple();
    return _persistAndReturn(response);
  }
}
