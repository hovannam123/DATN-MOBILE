import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookProvider with ChangeNotifier {
  LoginResult? account;

  void login() async {
    await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      account = value;
    });
    notifyListeners();
  }

  Future logOut() async {
    account = await FacebookAuth.instance.logOut().then((value) => null);
    notifyListeners();
  }
}
