import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 450,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              _add();
            },
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: () {
              _clear();
            },
            child: Text('清空'),
          ),
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String temp = '打开军火库九九';
    testList.add(temp);
    preferences.setStringList('cartList', testList);
    _show();
  }

  void _show() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getStringList('cartList') != null) {
      setState(() {
        testList = preferences.getStringList('cartList');
      });
    }
  }

  void _clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.clear(); 删除全部

    preferences.remove('cartList');
    setState(() {
      testList = [];
    });
  }
}
