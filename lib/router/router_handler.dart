import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/goods_details_page.dart';

Handler goodsDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print('goodsID-------------${goodsId}');
  return GoodsDetailsPage(goodsId);
});
