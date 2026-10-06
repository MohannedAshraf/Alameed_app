
import 'package:alameed_app/core/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../../../core/network/api_exception.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._firebaseAuthService);

  final FirebaseAuthService _firebaseAuthService;

  // ---------------------------------------------------------------------
  // Email / Phone+OTP — لسه MOCKED لحد ما الباك اند بتاعنا يجهز.
  // ---------------------------------------------------------------------
  Future<AuthResponseModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakeResponse(name: email.split('@').first, email: email);
  }

  Future<void> sendOtp({required String phone}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<AuthResponseModel> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
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

  // ---------------------------------------------------------------------
  // Google / Apple — حقيقيين دلوقتي عن طريق Firebase.
  // ---------------------------------------------------------------------
  Future<AuthResponseModel> loginWithGoogle() async {
    final firebaseUser = await _firebaseAuthService.signInWithGoogle();
    return _responseFromFirebaseUser(firebaseUser);
  }

  Future<AuthResponseModel> loginWithApple() async {
    final firebaseUser = await _firebaseAuthService.signInWithApple();
    return _responseFromFirebaseUser(firebaseUser);
  }

  Future<AuthResponseModel> _responseFromFirebaseUser(fb.User user) async {
    final idToken = await user.getIdToken();
    return AuthResponseModel(
      user: UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        phone: user.phoneNumber ?? '',
        avatarUrl: user.photoURL,
      ),
      token: idToken ?? '',
    );
  }
}
