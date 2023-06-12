import 'package:flutter/cupertino.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

import '../api/api_request.dart';
import '../model/review_product.dart';
import '../model/size.dart';

class ReviewProductProvider with ChangeNotifier {
  List<ReviewProduct> _listComment = [];
  bool isLoad = false;

  get listComment => this._listComment;

  void getListComment(int product_id) async {
    isLoad = true;
    _listComment = await ApiRequest.instance.getReviewProduct(product_id);
    isLoad = false;
    notifyListeners();
  }

  Future<String> createComment(String content, int product_id) async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    print(user.id);
    String message =
        await ApiRequest.instance.createComment(content, user.id!, product_id);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
