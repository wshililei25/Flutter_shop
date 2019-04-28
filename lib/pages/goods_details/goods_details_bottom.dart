import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_provide.dart';
import '../../provide/current_index.dart';
import '../../provide/goods_details_provide.dart';

class GoodsDetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<GoodsDetailProvide>(context)
        .goodsDetailsEntity
        .data
        .goodInfo;

    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(90),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  //跳转到购物车
                  Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 90,
                  alignment: Alignment.center,
                  child: Icon(Icons.shopping_cart,
                      size: 25, color: Colors.pink[100]),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, val) {
                  int goodsCount = Provide.value<CartProvide>(context).allCount;
                  //定位到相邻weidget的具体相对位置
                  return Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                          color: Colors.pink[100],
                          border: Border.all(width: 2, color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        goodsCount.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(22)),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).save(
                  goodsDetails.goodsId,
                  goodsDetails.goodsName,
                  1,
                  goodsDetails.presentPrice,
                  goodsDetails.image1);
            },
            child: Container(
                width: ScreenUtil().setWidth(280),
                height: ScreenUtil().setHeight(90),
                alignment: Alignment.center,
                color: Colors.green[200],
                child: Text(
                  '加入购物车',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                )),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).remove();
            },
            child: Container(
                width: ScreenUtil().setWidth(282),
                height: ScreenUtil().setHeight(90),
                alignment: Alignment.center,
                color: Colors.pink[200],
                child: Text(
                  '立即购买',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(28)),
                )),
          ),
        ],
      ),
    );
  }
}
