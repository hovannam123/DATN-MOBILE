import 'dart:convert';

import 'package:safe_food/src/resource/model/cart_item.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  final BaseApi _baseApi = BaseApi();

  Future<List<CartItem>> getListCartItem(int userId) async {
    String url = "/all-cart-item?user_id=$userId";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => CartItem.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<String> addToCart(int productId, sizeId, quantity, int userId) async {
    String url = "/add-to-cart?user_id=$userId";
    Map<String, dynamic> body = {
      'product_id': productId,
      'size_id': sizeId,
      'quantity': quantity
    };
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> deleteCartItem(int cartItemId) async {
    String url = "/delete-cart-item";
    Map<String, dynamic> body = {"cart_item_id": cartItemId};
    var respond = await _baseApi.deleteMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> increaseQuantity(int cartItemId) async {
    String url = "/increase-quantity-item";
    Map<String, dynamic> body = {"cart_item_id": cartItemId};
    var respond = await _baseApi.putMethod(url, body: body);

    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> decreaseQuantity(int cartItemId) async {
    try {} catch (error) {}
    String url = "/decrease-quantity-item";
    Map<String, int> body = {"cart_item_id": cartItemId};
    var respond = await _baseApi.putMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }
}
