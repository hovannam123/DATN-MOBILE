import 'package:flutter/cupertino.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

import '../api/api_request.dart';
import '../model/size.dart';

class SizeProvider with ChangeNotifier {
  List<Size> _listSize = [];
  bool isLoad = false;

  get listSize => this._listSize;

  void getListSize() async {
    isLoad = true;
    String? token = await StoreData().retrieveToken();
    _listSize = await ApiRequest.instance.getAllSize(token!);
    isLoad = false;
    notifyListeners();
  }

  Future<String> createSize(Size size) async {
    isLoad = true;
    String message = await ApiRequest.instance.createSize(size);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> deleteSize(int sizeId) async {
    isLoad = true;
    String message = await ApiRequest.instance.deleteSize(sizeId);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
