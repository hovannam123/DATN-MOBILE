import 'package:flutter/cupertino.dart';
import 'package:safe_food/src/resource/model/user.dart';
import 'package:safe_food/src/resource/repositories/review_repo.dart';
import 'package:safe_food/src/resource/store_data/store_data.dart';

import '../model/review_product.dart';

class ReviewProvider with ChangeNotifier {
  final ReviewRepository _reviewRepository = ReviewRepository();
  List<ReviewProduct> _listComment = [];
  bool isLoad = false;

  get listComment => this._listComment;

  void getListReview(int productId) async {
    isLoad = true;
    _listComment = await _reviewRepository.getListReview(productId);
    isLoad = false;
    notifyListeners();
  }

  Future<String> createComment(String content, int productId) async {
    isLoad = true;
    User? user = await StoreData().retrieveUser();
    print(user.id);
    String message =
        await _reviewRepository.createComment(content, productId, user.id!);
    isLoad = false;
    notifyListeners();
    return message;
  }
}
