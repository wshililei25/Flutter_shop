import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/cart_provide.dart';
import '../../provide/goods_details_provide.dart';
import 'package:provide/provide.dart';

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
          InkWell(
            onTap: () {},
            child: Container(
              width: 90,
              alignment: Alignment.center,
              child:
                  Icon(Icons.shopping_cart, size: 25, color: Colors.pink[100]),
            ),
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
              Provide.value<CartProvide>(context).remove();
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
