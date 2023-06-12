import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safe_food/src/resource/model/bill.dart';
import 'package:safe_food/src/resource/model/bill_item.dart';
import 'package:safe_food/src/resource/model/review_product.dart';
import 'package:safe_food/src/resource/model/top_product_favourite.dart';
import 'package:safe_food/src/resource/model/top_product_selling.dart';
import '../model/cart_item.dart';
import '../model/product.dart';
import '../model/product_detail_model.dart';
import '../model/user.dart';
import '../model/size.dart';
import '../model/bill_chart.dart';
import '../store_data/store_data.dart';

class ApiRequest {
  static ApiRequest? _instance;

  ApiRequest._();

  static ApiRequest get instance => _instance ??= ApiRequest._();

  String urlRoot = "http://192.168.1.23:3000/api/v1";

  Future<String> login(String email, String password) async {
    String url = "$urlRoot/login";

    final storeData = StoreData();

    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      final token = json.decode(response.body)["token"];
      final userJson = json.decode(response.body)["user"];
      User user = User.fromJson(userJson);

      storeData.storeToken(token);
      storeData.storeUser(user);

      return token;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> register(
      String email, String password, String phone_number) async {
    String url = "$urlRoot/create-user";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'phone_number': phone_number
      }),
    );
    if (response.statusCode == 200) {
      String message = json.decode(response.body)["message"];
      return message;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> forgetPassword(String email) async {
    String url = "$urlRoot/forget-password";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'email': email}),
    );
    if (response.statusCode == 200) {
      String message = json.decode(response.body)["message"];
      return message;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> verify(String email, String code) async {
    String url = "$urlRoot/verify";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'email': email, 'code': code}),
    );
    if (response.statusCode == 200) {
      String message = json.decode(response.body)["message"];
      return message;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> resetPassword(String email, String password) async {
    String url = "$urlRoot/reset-password";
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      String message = json.decode(response.body)["message"];
      return message;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<Product>> getAllProduct() async {
    String url = "$urlRoot/all-product";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode
          .map((product) => Product.fromJson(product))
          .toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<ProductDetailModel> getProductDetail(int product_id) async {
    String url = "$urlRoot/detail-product-size?product_id=$product_id";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final productdetail = json.decode(response.body)["data"];
      return ProductDetailModel.fromJson(productdetail);
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<CartItem>> getCartItem(int user_id) async {
    String url = "$urlRoot/all-cart-item?user_id=$user_id";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> createPayment() async {
    String url = "$urlRoot/payment";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body)["url"];
      return responseDecode;
    } else {
      throw Exception('Failed to create payment');
    }
  }

  Future<bool> confirmPayment() async {
    String url = "$urlRoot/success";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      // payment failed
      return false;
    }
  }

  Future<String> addToCart(
      int product_id, size_id, quantity, int user_id) async {
    String url = "$urlRoot/add-to-cart?user_id=$user_id";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'product_id': product_id,
        'size_id': size_id,
        'quantity': quantity
      }),
    );
    if (response.statusCode == 200) {
      final message = json.decode(response.body)["message"];

      return message;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> deleteCartItem(int cart_item_id, int user_id) async {
    String url = "$urlRoot/delete-cart-item?user_id=$user_id";
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'cart_item_id': cart_item_id,
      }),
    );
    if (response.statusCode == 200) {
      final message = json.decode(response.body)["message"];
      return message;
    } else {
      // payment failed
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> increaseQuantity(int cart_item_id, int user_id) async {
    String url = "$urlRoot/incease-quantity-item?user_id=$user_id";
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'cart_item_id': cart_item_id,
      }),
    );
    if (response.statusCode == 200) {
      final message = json.decode(response.body)["message"];
      return message;
    } else {
      // payment failed
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> decreaseQuantity(int cart_item_id, int user_id) async {
    String url = "$urlRoot/decease-quantity-item?user_id=$user_id";
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'cart_item_id': cart_item_id,
      }),
    );
    if (response.statusCode == 200) {
      final message = json.decode(response.body)["message"];
      return message;
    } else {
      // payment failed
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<Bill>> getAllBill() async {
    String url = "$urlRoot/all-bill";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((item) => Bill.fromJson(item)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<Bill>> getAllBillPending() async {
    String url = "$urlRoot/all-bill-pending";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((item) => Bill.fromJson(item)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<User>> getAllUser() async {
    String url = "$urlRoot/all-user";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<BillChart>> getBillCount() async {
    String url = "$urlRoot/bill-count";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((item) => BillChart.fromJson(item)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<BillItem>> getBillItem() async {
    String url = "$urlRoot/all-bill-item";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((item) => BillItem.fromJson(item)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<BillItem>> getBillItemPending() async {
    String url = "$urlRoot/all-bill-item-pending";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((item) => BillItem.fromJson(item)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> verifyOrder(int bill_id) async {
    String url = "$urlRoot/verify-order?id=$bill_id";
    final response = await http.put(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      String message = json.decode(response.body)["message"];
      return message;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> verifyAllOrder() async {
    String url = "$urlRoot/verify-all-order";
    final response = await http.put(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      String message = json.decode(response.body)["message"];
      return message;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<TopProductSelling>> getTopSellingProducts() async {
    String url = "$urlRoot/top-selling-product";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode
          .map((item) => TopProductSelling.fromJson(item))
          .toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<ProductDetailModel>> getAllProductDetail() async {
    String url = "$urlRoot/all-product-size";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode
          .map((product) => ProductDetailModel.fromJson(product))
          .toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<Size>> getAllSize(String token) async {
    String url = "$urlRoot/all-size";
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode.map((product) => Size.fromJson(product)).toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> createSize(Size size) async {
    String url = "$urlRoot/create-size";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'size_name': size.sizeName,
        'weigh': size.weigh,
        'height': size.height
      }),
    );
    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body)["message"];
      return responseDecode;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> deleteSize(int sizeId) async {
    String url = "$urlRoot/delete-size?id=$sizeId";
    final response = await http.delete(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body)["message"];
      return responseDecode;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<TopProductFavourite>> getTopProductFavourite() async {
    String url = "$urlRoot/top-product-favourite";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode
          .map((product) => TopProductFavourite.fromJson(product))
          .toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<ReviewProduct>> getReviewProduct(int product_id) async {
    String url = "$urlRoot/all-review-product?product_id=$product_id";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode
          .map((product) => ReviewProduct.fromJson(product))
          .toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> createComment(
      String content, int userId, int productId) async {
    String url =
        "$urlRoot/create-comment?user_id=$userId&product_id=$productId";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{'content': content}),
    );
    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body)["message"];
      return responseDecode;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<List<Product>> getProductFavourite(int userId) async {
    String url = "$urlRoot/all-product-favourite?user_id=$userId";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)["data"] as List<dynamic>;
      return responseDecode
          .map((product) => Product.fromJson(product["Product"]))
          .toList();
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> deleteProductFavourite(int productId, int userId) async {
    String url = "$urlRoot/delete-product-favourite?user_id=$userId";
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{'product_id': productId}),
    );
    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body)["message"];
      return responseDecode;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }

  Future<String> createProductFavourite(int productId, int userId) async {
    String url = "$urlRoot/create-product-favourite?user_id=$userId";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{'product_id': productId}),
    );
    if (response.statusCode == 200) {
      final responseDecode = json.decode(response.body)["message"];
      return responseDecode;
    } else {
      throw Exception('${json.decode(response.body)["message"]}');
    }
  }
}
