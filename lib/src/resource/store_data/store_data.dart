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

  void storeUserId(int user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', user_id);
  }

  Future<int?> retrieveUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
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
}
