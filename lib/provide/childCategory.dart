import 'package:flutter/material.dart';
import '../entity/category.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<CategorySecondEntity> childCategoryList = [];

  getChildCategory(List<CategorySecondEntity> list) {
    CategorySecondEntity all = CategorySecondEntity();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }
}
