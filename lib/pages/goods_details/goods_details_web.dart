import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/goods_details_provide.dart';

class GoodsDetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<GoodsDetailProvide>(context)
        .goodsDetailsEntity
        .data
        .goodInfo
        .goodsDetail;
    return Provide<GoodsDetailProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<GoodsDetailProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(data: goodsDetails),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text('暂无数据'),
          );
        }
      },
    );
  }
}
