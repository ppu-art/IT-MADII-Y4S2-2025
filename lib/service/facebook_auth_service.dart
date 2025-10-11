import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class FacebookAuthService {
  static FacebookAuthService instance = FacebookAuthService._internal();

  FacebookAuthService._internal();

  Future<void> facebookLogin() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.operationInProgress) {
        print("Operation in progress");
      } else if (result.status == LoginStatus.cancelled) {
        print("Operation in cancelled");
      } else if (result.status == LoginStatus.success) {
        print(result.accessToken!.tokenString);
        Get.snackbar("accessToken", result.accessToken!.tokenString);
        // Information from Facebook
        final userData = await FacebookAuth.instance.getUserData(
          fields: "email,name,picture.width(200)",
        );
        print('Email: ${userData['email']}');
        print('Picture:${userData['picture']['data']['url']}');

        String name = userData['name'];
        String photoURL = userData['picture']['data']['url'];

        // SignIn with Firebase
        OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);
        // Update information from facebook to Firebase
        if (userCredential.user != null) {
          await userCredential.user!.updateDisplayName(name);
          await userCredential.user!.updatePhotoURL(photoURL);
        }
      } else {
        print("Opertion is failed");
        Get.snackbar("Error", "Something went wrong");
      }
    } catch (error) {
      print("Error $error");
    }
  }

  Future<void> facebookLogOut() async {
    await FacebookAuth.instance.logOut();
  }
}
