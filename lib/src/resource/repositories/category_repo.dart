import 'package:safe_food/src/resource/model/category.dart';
import 'package:safe_food/src/resource/model/size.dart';
import 'package:safe_food/src/resource/struct/api_services/base_api.dart';

class CategoryRepository {
  final BaseApi _baseApi = BaseApi();

  Future<List<Category>> getListCategory() async {
    String url = "/all-category";
    var respond = await _baseApi.getMethod(url);
    if (respond["statusCode"] == 200) {
      return (respond["data"] as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw respond["message"];
    }
  }

  Future<String> createCategory(String categoryName) async {
    String url = "/create-category";
    Map<String, dynamic> body = {"name": categoryName};
    var respond = await _baseApi.postMethod(url, body: body);
    if (respond["statusCode"] == 200) {
      return respond["message"];
    } else {
      throw respond['message'];
    }
  }
}
