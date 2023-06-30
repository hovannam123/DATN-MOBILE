import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/model/top_product_favourite.dart';
import 'package:safe_food/src/resource/model/top_product_selling.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/repositories/product_repo.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();

  List<Product> _listProduct = [];
  List<Product> _listProductByCategory = [];
  List<TopProductSelling> _listTopSelling = [];
  List<TopProductFavourite> _listTopFavourite = [];
  List<Product> _listFavourite = [];

  bool isLoad = false;
  get listProduct => this._listProduct;
  get listTopSelling => this._listTopSelling;
  get listTopFavourite => this._listTopFavourite;
  get listFavourite => this._listFavourite;
  get listProductByCategory => this._listProductByCategory;

  void getListProduct() async {
    isLoad = true;
    _listProduct = await _productRepository.getListProduct();
    isLoad = false;
    notifyListeners();
  }

  void searchProduct(int categoryId, String text) async {
    isLoad = true;
    _listProductByCategory =
        await _productRepository.searchProduct(categoryId, text);
    isLoad = false;
    notifyListeners();
  }

  void getListProductByCategory(int categoryId) async {
    isLoad = true;
    _listProductByCategory =
        await _productRepository.getListProductByCategory(categoryId);
    isLoad = false;
    notifyListeners();
  }

  void getListTopSelling() async {
    isLoad = true;
    _listTopSelling = await _productRepository.getListTopSelling();
    isLoad = false;
    notifyListeners();
  }

  void getListTopFavourite() async {
    isLoad = true;
    _listTopFavourite = await _productRepository.getListTopFavourite();
    isLoad = false;
    notifyListeners();
  }

  void getListFavorite() async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    print(_listFavourite);
    print(user.toJson());
    _listFavourite = await _productRepository.getListFavorite(user.id!);
    isLoad = false;
    notifyListeners();
  }

  Future<String> deleteProductFavourite(int productId) async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    String message =
        await _productRepository.deleteProductFavourite(user.id!, productId);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> createProductFavourite(int productId) async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    String message =
        await _productRepository.createProductFavourite(user.id!, productId);
    isLoad = false;
    notifyListeners();
    return message;
  }

  Future<String> createProduct(
      int categoryId, String name, String description, double price) async {
    isLoad = true;
    String message = await _productRepository.createProduct(
        categoryId, name, description, price);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
