import 'dart:convert';

import 'package:flutter/material.dart';

import '../config/service_method.dart';
import '../entity/goodDetails.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailsEntity goodsDetailsEntity = null;

  getGoodsDetais(String id) {
    var formData = {'goodId': id};

    request('getGoodDetails', formData: formData).then((val) {
      var result = json.decode(val.toString());
      print('商品详情  ----  $result');
      goodsDetailsEntity = GoodsDetailsEntity.fromJson(result);
      notifyListeners();
    });
  }
}
