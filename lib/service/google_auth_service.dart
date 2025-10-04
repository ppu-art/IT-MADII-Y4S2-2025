import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final GoogleAuthService instance = GoogleAuthService._internal();

  GoogleAuthService._internal();

  Future<void> googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();
    try {
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      e.printError();
    }
  }

  Future<void> googleSignOut() async {
    await GoogleSignIn().signOut();
  }
}
