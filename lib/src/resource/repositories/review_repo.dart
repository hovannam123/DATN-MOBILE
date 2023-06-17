import 'package:safe_food/src/resource/model/review_product.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class ReviewRepository {
  final BaseApi _baseApi = BaseApi();

  Future<List<ReviewProduct>> getListReview(int productId) async {
    String url = "/all-review-product?product_id=$productId";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => ReviewProduct.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<String> createComment(
      String content, int productId, int userId) async {
    String url = "/create-comment?user_id=$userId&product_id=$productId";
    Map<String, dynamic> body = {"content": content};
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }
}
