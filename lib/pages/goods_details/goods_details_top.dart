import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/goods_details_provide.dart';

class GoodsDetailsTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(
      builder: (context, child, val) {
        var goodsDetails = Provide.value<GoodsDetailProvide>(context)
            .goodsDetailsEntity
            .data
            .goodInfo;

        if (goodsDetails != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsDetails.image1),
                _goodsName(goodsDetails.goodsName),
                _goodsNumber(goodsDetails.goodsSerialNumber),
                _goodsPrice(goodsDetails.presentPrice.toString(),
                    goodsDetails.oriPrice.toString()),
              ],
            ),
          );
        } else {
          return Text('正在加载中');
        }
      },
    );
  }

  /**
   * 商品图片
   */
  Widget _goodsImage(url) {
    return Image.network(url, width: ScreenUtil().setWidth(740));
  }

  /**
   * 商品名称
   */
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15, top: 8),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  /**
   * 商品编号
   */
  Widget _goodsNumber(number) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
      child: Text('编号：$number', style: TextStyle(color: Colors.black26)),
    );
  }

  /**
   * 商品价格
   */
  Widget _goodsPrice(price, marketPrice) {
    return Container(
//        width: ScreenUtil().setWidth(730),
        padding: EdgeInsets.only(left: 15, bottom: 8),
        child: Row(
          children: <Widget>[
            Text(price,
                style: TextStyle(
                    color: Colors.pink[100], fontSize: ScreenUtil().setSp(30))),
            _goodsMarketPrice(marketPrice),
          ],
        ));
  }

  Widget _goodsMarketPrice(marketPrice) {
    return Container(
//      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Text('市场价：',
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenUtil().setSp(28))),
          Text(
            '¥ $marketPrice',
            style: TextStyle(
                color: Colors.black26,
                fontSize: ScreenUtil().setSp(27),
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
