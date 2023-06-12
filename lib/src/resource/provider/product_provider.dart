import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/api/api_request.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/model/top_product_favourite.dart';
import 'package:safe_food/src/resource/model/top_product_selling.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _listProduct = [];
  List<TopProductSelling> _listTopSelling = [];
  List<TopProductFavourite> _listTopFavourite = [];
  List<Product> _listFavourite = [];

  bool isLoad = false;
  get listProduct => this._listProduct;
  get listTopSelling => this._listTopSelling;
  get listTopFavourite => this._listTopFavourite;
  get listFavourite => this._listFavourite;

  void getListProduct() async {
    isLoad = true;
    _listProduct = await ApiRequest.instance.getAllProduct();
    isLoad = false;
    notifyListeners();
  }

  void getListTopSelling() async {
    isLoad = true;
    _listTopSelling = await ApiRequest.instance.getTopSellingProducts();
    isLoad = false;
    notifyListeners();
  }

  void getListTopFavourite() async {
    isLoad = true;
    _listTopFavourite = await ApiRequest.instance.getTopProductFavourite();
    isLoad = false;
    notifyListeners();
  }

  void getListFavorite() async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    _listFavourite = await ApiRequest.instance.getProductFavourite(user.id!);
    isLoad = false;
    notifyListeners();
  }

  Future<String> deleteProductFavourite(int productId) async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    String message =
        await ApiRequest.instance.deleteProductFavourite(productId, user.id!);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> createProductFavourite(int productId) async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    String message =
        await ApiRequest.instance.createProductFavourite(productId, user.id!);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
