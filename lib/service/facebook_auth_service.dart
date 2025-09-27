import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthService {
  static FacebookAuthService instance = FacebookAuthService._internal();

  FacebookAuthService._internal();

  Future<void> facebookSignOut() async {
    await FacebookAuth.instance.logOut();
    await FirebaseAuth.instance.signOut();
  }
}
