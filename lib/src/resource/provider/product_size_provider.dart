// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/repositories/product_size_repo.dart';
import 'package:safe_food/src/resource/repositories/size_repo.dart';

import '../model/size.dart';

class ProductSizeProvider with ChangeNotifier {
  final ProductSizeRepository _productSizeRepository = ProductSizeRepository();

  bool isLoad = false;

  Future<String> createProductSize(
      int productID, int sizeId, int amount) async {
    isLoad = true;
    String message = await _productSizeRepository.createProductSize(
        sizeId, productID, amount);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
