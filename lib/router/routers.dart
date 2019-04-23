import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String root = '/';
  static String goodsDetailPage = '/detail'; //商品详情

  static void configRoute(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('路由不存在');
    });

    router.define(goodsDetailPage, handler: goodsDetailHandler);
  }
}
