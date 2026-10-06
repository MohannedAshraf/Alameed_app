import 'package:alameed_app/core/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../../../core/network/api_exception.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._firebaseAuthService);

  final FirebaseAuthService _firebaseAuthService;

  // ------------------S---------------------------------------------------
  // Email/Password — حقيقي دلوقتي عن طريق Firebase.
  // ---------------------------------------------------------------------
  Future<AuthResponseModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _firebaseAuthService.signInWithEmail(
        email: email,
        password: password,
      );
      return _responseFromFirebaseUser(user);
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  Future<AuthResponseModel> registerWithEmail({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final user = await _firebaseAuthService.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      // Firebase لحساب الإيميل/الباسورد مش بيخزن رقم الموبايل (ده محتاج
      // flow تحقق منفصل بالـ OTP)، فبنسيب رقم الموبايل اللي المستخدم
      // كتبه هنا بدل ما ناخده من user.phoneNumber (هيبقى فاضي). لما
      // الباك اند الحقيقي يجهز، هو اللي هيخزنه كـ profile field.
      return _responseFromFirebaseUser(user, phoneOverride: phone);
    } on fb.FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  // ---------------------------------------------------------------------
  // Phone + OTP — لسه MOCKED (محتاج باك اند حقيقي لإرسال الـ SMS).
  // ---------------------------------------------------------------------
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
    return AuthResponseModel(
      user: UserModel(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        phone: phone,
      ),
      token: 'fake-token-for-ui-testing',
    );
  }

  // ---------------------------------------------------------------------
  // Google / Apple — حقيقيين عن طريق Firebase.
  // ---------------------------------------------------------------------
  Future<AuthResponseModel> loginWithGoogle() async {
    final firebaseUser = await _firebaseAuthService.signInWithGoogle();
    return _responseFromFirebaseUser(firebaseUser);
  }

  Future<AuthResponseModel> loginWithApple() async {
    final firebaseUser = await _firebaseAuthService.signInWithApple();
    return _responseFromFirebaseUser(firebaseUser);
  }

  // ---------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------
  Future<AuthResponseModel> _responseFromFirebaseUser(
    fb.User user, {
    String? phoneOverride,
  }) async {
    final idToken = await user.getIdToken();
    return AuthResponseModel(
      user: UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        phone: phoneOverride ?? user.phoneNumber ?? '',
        avatarUrl: user.photoURL,
      ),
      token: idToken ?? '',
    );
  }

  ApiException _mapFirebaseError(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return ApiException('common.email_already_in_use');
      case 'weak-password':
        return ApiException('common.weak_password');
      case 'invalid-email':
        return ApiException('common.invalid_email');
      case 'user-not-found':
        return ApiException('common.user_not_found');
      case 'wrong-password':
      case 'invalid-credential':
        return ApiException('common.wrong_password');
      case 'too-many-requests':
        return ApiException('common.too_many_requests');
      case 'network-request-failed':
        return ApiException('common.no_internet');
      default:
        return ApiException('common.something_went_wrong');
    }
  }
}
