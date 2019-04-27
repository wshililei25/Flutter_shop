import 'dart:convert';

import 'package:flutter/material.dart';

import '../config/service_method.dart';
import '../entity/goodDetails.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailsEntity goodsDetailsEntity = null;

  bool isLeft = true;
  bool isRight = false;

  getGoodsDetais(String id) async {
    var formData = {'goodId': id};

    await request('getGoodDetails', formData: formData).then((val) {
      var result = json.decode(val.toString());
      print('商品详情  ----  $result');
      goodsDetailsEntity = GoodsDetailsEntity.fromJson(result);
      notifyListeners();
    });
  }

  /**
   * tabbar切换
   */
  changeTabbar(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
