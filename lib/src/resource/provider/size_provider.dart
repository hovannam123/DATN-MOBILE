import 'package:flutter/cupertino.dart';
import 'package:safe_food/src/resource/repositories/size_repo.dart';

import '../model/size.dart';

class SizeProvider with ChangeNotifier {
  final SizeRepository _sizeRepository = SizeRepository();
  List<Size> _listSize = [];
  bool isLoad = false;

  get listSize => this._listSize;

  void getListSize() async {
    isLoad = true;
    _listSize = await _sizeRepository.getListSize();
    isLoad = false;
    notifyListeners();
  }

  Future<String> createSize(
      String sizeName, String weigh, String height) async {
    isLoad = true;
    String message = await _sizeRepository.createSize(sizeName, weigh, height);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> updateSize(int sizeId, String weigh, String height) async {
    isLoad = true;
    String message = await _sizeRepository.updateSize(sizeId, weigh, height);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
