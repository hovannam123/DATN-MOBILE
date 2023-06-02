import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/model/user.dart';

import '../modules/user/home_page/home_page.dart';

class LoginProvider with ChangeNotifier {
  String? _token = "";
  User? _user;
  bool isLoad = false;

  get token => this._token;
  get user => this._user;

  Future<void> login(
      String username, String password, BuildContext context) async {
    isLoad = true;
    await ApiRequest.instance
        .login(username, password)
        .then((value) => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()))
            })
        .catchError((error) {
      if (error is Exception) {
        CupertinoAlertDialog(
          title: Text("Không thể đăng nhập"),
          actions: [
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok")),
          ],
          content: Text('${error.toString().split("Exception: ")[1]}'),
        );
      }
    });
    isLoad = false;
    notifyListeners();
  }

  // void getUserDetail(String token) async {
  //   _user = await apiRequest.getUser(token);
  //   notifyListeners();
  // }

  // void storeToken(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('token', token);
  //   notifyListeners();
  // }

  // Future<String> loadToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token').toString();
  // }
}
