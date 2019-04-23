import 'package:flutter/material.dart';

import '../entity/category.dart';

class ChildCategoryProvide with ChangeNotifier {
  List<CategorySecondEntity> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '4'; //大类id
  String categoryChildId = ''; //子类id
  int page = 1;
  String noMoreText = ''; //上拉加载无数据提示

  /**
   * 大类切换
   */
  getChildCategory(List<CategorySecondEntity> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;
    CategorySecondEntity all = CategorySecondEntity();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = '';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  /**
   * 子类切换
   */
  changeChildIndex(index, String childId) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    categoryChildId = childId;
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
