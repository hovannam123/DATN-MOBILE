import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _listProduct = [];
  bool isLoad = false;
  get listProduct => this._listProduct;

  void getListProduct() async {
    isLoad = true;
    _listProduct = await ApiRequest.instance.getAllProduct();
    isLoad = false;
    notifyListeners();
  }
}
