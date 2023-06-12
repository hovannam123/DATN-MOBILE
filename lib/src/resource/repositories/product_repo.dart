import 'package:safe_food/src/resource/model/product.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class ProductRepository {
  final BaseApi _baseApi = BaseApi();
  Future<List<Product>> getListProduct() async {
    String url = "/all-product";
    var respond = await _baseApi.getMethod(url);
    if (respond['statusCode'] == 200) {
      return (respond['data'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } else {
      throw respond['message'];
    }
  }
}
