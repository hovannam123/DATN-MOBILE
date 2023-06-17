import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/model/user_information.dart';
import 'package:safe_food/src/resource/repositories/user_repo.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  List<User> _listUser = [];
  User? _user;
  bool isLoad = false;

  get listUser => this._listUser;
  get user => this._user;

  void getListUser() async {
    isLoad = true;
    _listUser = await _userRepository.getListUser();
    isLoad = false;
    notifyListeners();
  }

  Future<User?> getUserDetail() async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    _user = await _userRepository.getUserDetail(user.id!);
    isLoad = false;
    notifyListeners();
    return _user;
  }

  Future<String> updateUserInformation(
      String firstName, String lastName, bool gender, String birthday) async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    String message = await _userRepository.updateUserInformation(
        user.id!, firstName, lastName, gender, birthday);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
