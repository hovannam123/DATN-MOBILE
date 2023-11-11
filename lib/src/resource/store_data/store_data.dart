import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:safe_food/src/resource/model/user.dart';

class StoreData {
  void storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void storeUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(user.toJson());

    await prefs.setString('user', json);
  }

  Future<User> retrieveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('user');
    Map<String, dynamic> userJson = jsonDecode(json!);
    return User.fromJson(userJson);
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }
}
