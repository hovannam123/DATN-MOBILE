import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/model/bill.dart';
import 'package:safe_food/src/resource/model/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _listUser = [];
  bool isLoad = false;

  get listUser => this._listUser;

  void getListUser() async {
    isLoad = true;
    _listUser = await ApiRequest.instance.getAllUser();
    isLoad = false;
    notifyListeners();
  }
}
