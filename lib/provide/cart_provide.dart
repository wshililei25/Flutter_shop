import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entity/cart.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartEntity> cartList = [];
  SharedPreferences preferences;
  double allPrice = 0.0;
  int allCount = 0;
  bool isAllCheck = true;

  save(goodsId, goodsName, count, price, image) async {
    preferences = await SharedPreferences.getInstance();
    cartString = preferences.get('cart');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int index = 0;
    allPrice = 0.0;
    allCount = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[index]['count'] = item['count'] + 1;
        cartList[index].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice += cartList[index].price * cartList[index].count;
        allCount += cartList[index].count;
      }
      index++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'image': image,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(CartEntity.fromJson(newGoods));

      allPrice += price * count;
      allCount += count;
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
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0.0;
      allCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        cartList.add(CartEntity.fromJson(item));
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allCount += item['count'];
        } else {
          isAllCheck = false;
        }
      });
    }
    notifyListeners();
  }

  /**
   * 删除商品
   */
  deleteCart(String goodsId) async {
    cartString = preferences.getString('cart');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int deleteIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        deleteIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(deleteIndex);
    cartString = json.encode(tempList).toString();
    preferences.setString('cart', cartString);
    await getCartInfo();
  }

  /**
   * 商品选择
   */
  checkState(CartEntity cartItem) async {
    cartString = preferences.getString('cart');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int checkIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        checkIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[checkIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    preferences.setString('cart', cartString);
    await getCartInfo();
  }

  /**
   * 全选
   */
  checkAll(bool isCheck) async {
    cartString = preferences.getString('cart');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    preferences.setString('cart', cartString);
    await getCartInfo();
  }

  /**
   * 商品数量加减
   */
  countAddOrSubtarct(var cartItem, String todo) async {
    cartString = preferences.getString('cart');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int countIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        countIndex = tempIndex;
      }
      tempIndex++;
    });

    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[countIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    preferences.setString('cart', cartString);
    await getCartInfo();
  }
}
