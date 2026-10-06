import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Wraps Firebase Auth + the native Google/Apple sign-in flows. Returns a
/// Firebase User once the person is authenticated — AuthRemoteDataSource
/// turns that into our own AuthResponseModel.
class FirebaseAuthService {
  final _firebaseAuth = fb.FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future<fb.User> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // المستخدم قفل نافذة اختيار الحساب — مش خطأ حقيقي.
      throw fb.FirebaseAuthException(code: 'sign_in_cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user!;
  }

  Future<fb.User> signInWithApple() async {
    final rawNonce = _generateNonce();
    final hashedNonce = _sha256Hash(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final oauthCredential = fb.OAuthProvider(
      'apple.com',
    ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

    final userCredential = await _firebaseAuth.signInWithCredential(
      oauthCredential,
    );
    final user = userCredential.user!;

    // آبل بيبعت الاسم أول مرة بس في حياة الحساب — Firebase مش بياخده
    // تلقائي، فبنحدث الـ profile إحنا بإيدينا.
    if (appleCredential.givenName != null &&
        (user.displayName == null || user.displayName!.isEmpty)) {
      final fullName =
          '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'
              .trim();
      await user.updateDisplayName(fullName);
      await user.reload();
    }

    return _firebaseAuth.currentUser!;
  }

  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256Hash(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }
}
