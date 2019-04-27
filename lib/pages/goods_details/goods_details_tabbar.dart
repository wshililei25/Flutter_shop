import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/goods_details_provide.dart';

class GoodsDetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<GoodsDetailProvide>(context).isLeft;
        var isRight = Provide.value<GoodsDetailProvide>(context).isRight;

        return Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: <Widget>[
              _leftTabBarLeft(context, isLeft),
              _rightTabBarLeft(context, isRight)
            ],
          ),
        );
      },
    );
  }

  Widget _leftTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailProvide>(context).changeTabbar('left');
      },
      child: Container(
        padding: EdgeInsets.all(15),
        //居中
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: isLeft ? Colors.pink[100] : Colors.black12))),
        child: Text(
          '详情',
          style: TextStyle(color: isLeft ? Colors.pink[100] : Colors.black26),
        ),
      ),
    );
  }

  Widget _rightTabBarLeft(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailProvide>(context).changeTabbar('right');
      },
      child: Container(
        padding: EdgeInsets.all(15),
        //居中
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1,
                    color: isRight ? Colors.pink[100] : Colors.black12))),
        child: Text(
          '评论',
          style: TextStyle(color: isRight ? Colors.pink[100] : Colors.black26),
        ),
      ),
    );
  }
}
