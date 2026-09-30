import '../../../../core/network/api_exception.dart';
import '../models/user_model.dart';

/// MOCKED for now — backend auth endpoints aren't finalized yet.
///
/// Swap the body of each method below for a real DioClient() call once
/// the backend is ready. Signatures stay the same, so nothing above this
/// layer (repository/usecases/blocs/screens) needs to change. Example of
/// what a real call will look like:
///
/// final response = await DioClient().post(ApiEndpoints.login, data: {
///   'email': email,
///   'password': password,
/// });
/// return AuthResponseModel.fromJson(response.data);
class AuthRemoteDataSource {
  Future<AuthResponseModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakeResponse(name: email.split('@').first, email: email);
  }

  Future<void> sendOtp({required String phone}) async {
    await Future.delayed(const Duration(seconds: 1));
    // Real call just triggers the SMS — nothing to return.
  }

  Future<AuthResponseModel> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    // Use 1234 while testing — mimics a real bad-response error so the
    // bloc/UI failure path is already correct once real calls are wired in.
    if (otp != '1234') {
      throw ApiException('common.invalid_otp');
    }
    return _fakeResponse(name: 'Test User', phone: phone);
  }

  Future<AuthResponseModel> registerWithEmail({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakeResponse(name: name, email: email, phone: phone);
  }

  Future<AuthResponseModel> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: once `google_sign_in` is added + configured (Firebase project,
    // SHA-1 fingerprint, OAuth client ID), fetch the real Google idToken
    // here and send it to ApiEndpoints.googleLogin instead.
    return _fakeResponse(name: 'Google User', email: 'google.user@example.com');
  }

  Future<AuthResponseModel> loginWithApple() async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: same idea with `sign_in_with_apple` (needs the "Sign in with
    // Apple" capability on the Apple Developer account) + ApiEndpoints.appleLogin.
    return _fakeResponse(name: 'Apple User', email: 'apple.user@example.com');
  }

  AuthResponseModel _fakeResponse({
    String name = 'Test User',
    String email = 'test@example.com',
    String phone = '01000000000',
  }) {
    return AuthResponseModel(
      user: UserModel(id: '1', name: name, email: email, phone: phone),
      token: 'fake-token-for-ui-testing',
    );
  }
}
