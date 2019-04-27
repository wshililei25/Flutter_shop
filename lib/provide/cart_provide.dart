import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/cart.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartEntity> cartList = [];
  SharedPreferences preferences;

  save(goodsId, goodsName, count, price, image) async {
    preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cart');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int index = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        cartList[index].count++;
        isHave = true;
      }
      index++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'image': image
      };
      tempList.add(newGoods);
      cartList.add(CartEntity.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    print('购物车----$cartString');
    print('购物车数量----${cartList.length}');
    preferences.setString('cart', cartString);
    notifyListeners();
  }

  remove() async {
    preferences.remove('cart');
    cartList.clear();
    print('购物车清空');
    notifyListeners();
  }

  getCartInfo() async {
    cartString = preferences.getString('cart');
    cartList.clear();
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        cartList.add(CartEntity.fromJson(item));
      });
    }
    notifyListeners();
  }
}
