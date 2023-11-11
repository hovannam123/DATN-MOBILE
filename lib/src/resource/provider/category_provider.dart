import 'package:flutter/cupertino.dart';
import 'package:safe_food/src/resource/model/category.dart';
import 'package:safe_food/src/resource/repositories/category_repo.dart';
import 'package:safe_food/src/resource/repositories/size_repo.dart';

class CategoryProvider with ChangeNotifier {
  int _selectedIndex = 0;
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<Category> _listCategory = [];
  bool isLoad = false;

  get listCategory => this._listCategory;
  get selectedIndex => this._selectedIndex;

  void getListCategory(int roleId) async {
    isLoad = true;
    _listCategory = await _categoryRepository.getListCategory();
    if (roleId == 2) {
      _listCategory.insert(
          0, Category(id: 0, name: 'Tất cả', deleteFlag: false));
    }

    isLoad = false;
    notifyListeners();
  }

  Future<String> createCategory(String categoryName) async {
    isLoad = true;
    String message = await _categoryRepository.createCategory(categoryName);
    isLoad = false;
    notifyListeners();
    return message;
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
