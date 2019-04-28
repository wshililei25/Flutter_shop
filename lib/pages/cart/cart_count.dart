import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_provide.dart';

class CartCount extends StatelessWidget {
  var item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(160),
      margin: EdgeInsets.only(top: 5),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_subtract(context), _num(), _add(context)],
      ),
    );
  }

  Widget _subtract(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context)
            .countAddOrSubtarct(item, 'subtract');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(color: Colors.black12, width: 1))),
        child: Text('-'),
      ),
    );
  }

  Widget _num() {
    return InkWell(
      onTap: () {},
      child: Container(
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        child: Text(item.count.toString()),
      ),
    );
  }

  Widget _add(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).countAddOrSubtarct(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(40),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(color: Colors.black12, width: 1))),
        child: Text('+'),
      ),
    );
  }
}
