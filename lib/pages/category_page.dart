import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/service_method.dart';
import '../entity/category.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('商品分类',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
          preferredSize: Size.fromHeight(55)),
      body: Container(
        child: Row(
          children: <Widget>[LeftNavState()],
        ),
      ),
    );
  }
}

/**
 * 左侧大类导航
 */
class LeftNavState extends StatefulWidget {
  @override
  _LeftNavStateState createState() => _LeftNavStateState();
}

class _LeftNavStateState extends State<LeftNavState> {
  List list = [];

  @override
  void initState() {
    super.initState();
    _getCategroy();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _lestInkWell(index);
        },
      ),
    );
  }

  Widget _lestInkWell(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26.0)),
        ),
      ),
    );
  }

  void _getCategroy() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());

      CategoryEntity categoryEntity = CategoryEntity.fromJson(data);
//      list.data.forEach((item) => print('返回---${item.mallCategoryName}'));
      setState(() {
        list = categoryEntity.data;
      });
    });
  }
}
