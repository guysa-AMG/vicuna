import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepo {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> googleSignIn() async {
    await GoogleSignIn.instance.initialize();
    
    GoogleSignInAccount acc = await GoogleSignIn.instance.authenticate();
    GoogleSignInAuthentication ggAuth = acc.authentication;
    UserCredential cred = await auth.signInWithCredential(
      GoogleAuthProvider.credential(idToken: ggAuth.idToken)
    
    );

    return cred;
  }

  Future<UserCredential?> anonLogin() async {
    UserCredential cred = await auth.signInAnonymously();
    return cred;
  }

  Future<UserCredential?> facebookSignIn() async {
    LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      AccessToken token = result.accessToken!;
      OAuthCredential facebookcred = FacebookAuthProvider.credential(
        token.tokenString,
      );
      UserCredential cred = await auth.signInWithCredential(facebookcred);
      return cred;
    }
    return null;
  }

  Future<bool> logOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }
}
