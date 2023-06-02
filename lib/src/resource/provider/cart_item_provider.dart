import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/model/cart_item.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';
import 'package:safe_food/src/resource/api/api_request.dart';

class CartItemProvider with ChangeNotifier {
  List<CartItem> _listCartItem = [];
  final storeData = StoreData();
  bool isLoad = false;
  get listCartItem => this._listCartItem;

  void getListCartItem() async {
    isLoad = true;
    User? user = await storeData.retrieveUser();
    _listCartItem = await ApiRequest.instance.getCartItem(user.id!);
    isLoad = false;
    notifyListeners();
  }

  Future<String> deleteCartItem(int cart_item_id) async {
    User? user = await storeData.retrieveUser();

    String message =
        await ApiRequest.instance.deleteCartItem(cart_item_id, user.id!);
    notifyListeners();
    return message;
  }

  Future<String> increaseQuantity(int cart_item_id) async {
    User? user = await storeData.retrieveUser();

    String message =
        await ApiRequest.instance.increaseQuantity(cart_item_id, user.id!);
    notifyListeners();
    return message;
  }

  Future<String> decreaseQuantity(int cart_item_id) async {
    User? user = await storeData.retrieveUser();

    String message =
        await ApiRequest.instance.decreaseQuantity(cart_item_id, user.id!);
    notifyListeners();
    return message;
  }
}
