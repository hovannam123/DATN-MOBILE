import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/repositories/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  User? _user;
  bool isLoad = false;

  get user => this._user;

  Future<String> login(String email, String password) async {
    isLoad = true;
    String message =
        await _authRepository.login(email: email, password: password);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> signup(
      String email, String password, String phoneNumber) async {
    isLoad = true;
    String message = await _authRepository.signup(
        email: email, password: password, phone_number: phoneNumber);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> forgetPassword(String email) async {
    isLoad = true;
    String message = await _authRepository.forgetPassword(email: email);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> verify(String email, String code) async {
    isLoad = true;
    String message = await _authRepository.verify(email: email, code: code);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> resetPassword(String email, String password) async {
    isLoad = true;
    String message =
        await _authRepository.resetPassword(email: email, password: password);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
