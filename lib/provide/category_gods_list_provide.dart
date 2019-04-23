import 'package:flutter/material.dart';
import '../entity/categoryGoods.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<GoodEntity> list = [];

  /**
   * 点击大类更换商品列表
   */
  getGoodsList(List<GoodEntity> goodsList) {
    list = goodsList;
    notifyListeners();
  }

  getMoreGoodsList(List<GoodEntity> goodsList) {
    list.addAll(goodsList);
    notifyListeners();
  }
}
