import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/model/product_detail.dart';
import 'package:safe_food/src/resource/repositories/product_detail_repo.dart';

class ProductDetailProvider with ChangeNotifier {
  final ProductDetailRepository _productDetailRepository =
      ProductDetailRepository();
  ProductDetail? _productDetail;
  List<ProductDetail> _listProduct = [];

  bool isLoad = false;
  get productDetail => this._productDetail;
  get listProduct => this._listProduct;

  void getProductDetail(int productId) async {
    isLoad = true;
    _productDetail = await _productDetailRepository.getProductDetail(productId);
    isLoad = false;
    notifyListeners();
  }

  void getListProductDetail() async {
    isLoad = true;
    _listProduct = await _productDetailRepository.getListProductDetail();
    isLoad = false;
    notifyListeners();
  }
}
