import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/model/product_detail_model.dart';

class ProductDetailProvider with ChangeNotifier {
  ProductDetailModel? _productDetail;
  bool isLoad = false;
  get productDetail => this._productDetail;

  void getListProduct(int product_id) async {
    isLoad = true;
    _productDetail = await ApiRequest.instance.getProductDetail(product_id);
    isLoad = false;
    notifyListeners();
  }
}
