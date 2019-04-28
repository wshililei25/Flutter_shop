import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      child: Provide<CartProvide>(builder: (context, child, cal) {
        return Row(
          children: <Widget>[
            _checkBox(context),
            _price(context),
            _btn(context)
          ],
        );
      }),
    );
  }

  Widget _checkBox(context) {
    bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
              value: isAllCheck,
              activeColor: Colors.pink[100],
              onChanged: (bool val) {
                Provide.value<CartProvide>(context).checkAll(val);
              }),
          Text('全选')
        ],
      ),
    );
  }

  Widget _price(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(400),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(250),
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '¥${allPrice.toString()}',
                  style: TextStyle(
                      color: Colors.pink[100],
                      fontSize: ScreenUtil().setSp(36)),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(400),
            alignment: Alignment.centerRight,
            child: Text(
              '满10远免配送费',
              style: TextStyle(
                  color: Colors.black26, fontSize: ScreenUtil().setSp(22)),
            ),
          )
        ],
      ),
    );
  }

  Widget _btn(context) {
    int allCount = Provide.value<CartProvide>(context).allCount;
    return Container(
        width: ScreenUtil().setWidth(170),
        padding: EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text('结算($allCount)', style: TextStyle(color: Colors.white)),
          ),
        ));
  }
}
