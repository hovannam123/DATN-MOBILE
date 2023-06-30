import 'package:safe_food/src/resource/model/product_detail.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class ProductDetailRepository {
  final BaseApi _baseApi = BaseApi();

  Future<ProductDetail> getProductDetail(int productId) async {
    String url = "/detail-product-size?product_id=$productId";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return ProductDetail.fromJson(respond["data"]);
    } else {
      throw respond["message"];
    }
  }

  Future<List<ProductDetail>> getListProductDetail() async {
    String url = "/all-product-size";
    var respond = await _baseApi.getMethod(url);
    print(respond);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => ProductDetail.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }
}
