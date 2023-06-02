import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleProvider with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? account;
  String token = '';

  logIn() async {
    account = await _googleSignIn.signIn();
    account!.authentication.then(
      (value) {
        token = value.accessToken!;
      },
    );
    notifyListeners();
  }

  logOut() async {
    account = await _googleSignIn.signOut();
    notifyListeners();
  }
}
