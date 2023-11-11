import 'package:flutter/material.dart';
import 'package:safe_food/src/resource/model/cart_item.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/repositories/cart_repo.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

class CartItemProvider with ChangeNotifier {
  final CartRepository _cartRepository = CartRepository();
  final storeData = StoreData();

  List<CartItem> _listCartItem = [];
  bool isLoad = false;
  get listCartItem => this._listCartItem;

  void getListCartItem() async {
    // isLoad = true;
    User? user = await storeData.retrieveUser();
    _listCartItem = await _cartRepository.getListCartItem(user.id!);
    // isLoad = false;
    notifyListeners();
  }

  Future<String> addToCart(int productId, sizeId, quantity) async {
    User? user = await storeData.retrieveUser();

    String message =
        await _cartRepository.addToCart(productId, sizeId, quantity, user.id!);
    notifyListeners();
    return message;
  }

  Future<String> deleteCartItem(int cart_item_id) async {
    String message = await _cartRepository.deleteCartItem(cart_item_id);
    notifyListeners();
    return message;
  }

  Future<String> increaseQuantity(int cart_item_id) async {
    String message = await _cartRepository.increaseQuantity(cart_item_id);
    notifyListeners();
    return message;
  }

  Future<String> decreaseQuantity(int cart_item_id) async {
    String message = await _cartRepository.decreaseQuantity(cart_item_id);
    notifyListeners();
    return message;
  }
}
