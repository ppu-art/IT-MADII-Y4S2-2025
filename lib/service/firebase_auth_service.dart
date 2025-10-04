import 'package:firebase_auth/firebase_auth.dart';
import 'package:mad/service/facebook_auth_service.dart';
import 'package:mad/service/google_auth_service.dart';

class FirebaseAuthService {
  static final FirebaseAuthService instance = FirebaseAuthService._internal();

  FirebaseAuthService._internal();

  Future<void> logout() async {
    await FacebookAuthService.instance.facebookLogOut();
    await GoogleAuthService.instance.googleSignOut();
    await FirebaseAuth.instance.signOut();
  }
}
