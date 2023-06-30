import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class ProductSizeRepository {
  final BaseApi _baseApi = BaseApi();

  Future<String> importAmount(int productSizeId, int amount) async {
    String url = "/import-product-size?product_size_id=$productSizeId";
    Map<String, dynamic> body = {"amount": amount};
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }

  Future<String> createProductSize(
      int productId, int sizeId, int amount) async {
    String url = "/create-product-size";
    Map<String, dynamic> body = {
      "size_id": sizeId,
      "product_id": productId,
      "amount": amount
    };
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }
}
